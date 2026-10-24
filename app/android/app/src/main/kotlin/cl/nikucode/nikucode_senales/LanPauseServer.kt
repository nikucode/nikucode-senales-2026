package cl.nikucode.nikucode_senales

import android.content.Context
import android.net.nsd.NsdManager
import android.net.nsd.NsdServiceInfo
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Log
import java.io.BufferedReader
import java.io.InputStreamReader
import java.util.Collections
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.MessageDigest
import java.security.SecureRandom
import java.util.Date
import java.util.concurrent.Semaphore
import javax.net.ssl.KeyManagerFactory
import javax.net.ssl.SSLContext
import javax.net.ssl.SSLServerSocket
import javax.net.ssl.SSLSocket
import javax.security.auth.x500.X500Principal
import org.json.JSONObject

/** TLS endpoint owned by the connected-device foreground service. */
class LanPauseServer(
    private val activity: Context,
    private val queue: LanPauseStore,
) {
    companion object {
        private const val KEY_ALIAS = "nikucode_pause_lan_v3"
        private const val PREVIOUS_KEY_ALIAS = "nikucode_pause_lan_v2"
        private const val LOG_TAG = "NikucodeLan"
        private const val SERVICE_TYPE = "_nikucode-pause._tcp."
        private const val DESKTOP_TYPE = "_nikucode-desktop._tcp."
        private const val MAX_LINE = 65536
        private const val LISTEN_PORT = 46274
    }

    private val preferences = activity.getSharedPreferences("nikucode_lan_v1", Context.MODE_PRIVATE)
    private val nsd = activity.getSystemService(Context.NSD_SERVICE) as NsdManager
    private var server: SSLServerSocket? = null
    private var registration: NsdManager.RegistrationListener? = null
    private var pairingRegistration: NsdManager.RegistrationListener? = null
    private var pairingUntil = 0L
    private var pairingNonce: String? = null
    private var pairingTarget: String? = null
    @Volatile private var pairingCode: String? = null
    @Volatile private var phoneAccepted = false
    @Volatile private var pairRejected = false
    @Volatile private var pairSessionSocket: SSLSocket? = null
    private var discovery: NsdManager.DiscoveryListener? = null
    private val desktops = mutableMapOf<String, String>()
    private val random = SecureRandom()
    private val connections = Semaphore(4)
    private val activeSockets = Collections.synchronizedSet(mutableSetOf<SSLSocket>())
    @Volatile private var lastError: String? = null
    @Volatile private var lastSyncAt = 0L

    @Synchronized
    fun start() {
        if (server != null) return
        try {
            val context = SSLContext.getInstance("TLS")
            val store = identityStore()
            val factory = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm())
            factory.init(store, null)
            context.init(factory.keyManagers, null, random)
            val listener = context.serverSocketFactory.createServerSocket(LISTEN_PORT) as SSLServerSocket
            listener.soTimeout = 1000
            listener.enabledProtocols = listener.supportedProtocols
                .filter { it == "TLSv1.2" || it == "TLSv1.3" }
                .toTypedArray()
            server = listener
            advertise()
            Thread {
                while (server === listener) {
                    try {
                        val socket = listener.accept() as SSLSocket
                        if (connections.tryAcquire()) {
                            activeSockets.add(socket)
                            Thread {
                                try { handle(socket) } finally {
                                    activeSockets.remove(socket)
                                    connections.release()
                                }
                            }.start()
                        } else {
                            socket.close()
                        }
                    } catch (_: java.net.SocketTimeoutException) {
                        // Check whether the service is still running.
                    } catch (_: Exception) {
                        break
                    }
                }
            }.start()
        } catch (error: Exception) {
            lastError = "No se pudo iniciar TLS: ${error.javaClass.simpleName}"
            Log.e(LOG_TAG, "LAN TLS server could not start", error)
            stop()
        }
    }

    @Synchronized
    fun stop() {
        server?.close()
        server = null
        revoke()
        registration?.let {
            try { nsd.unregisterService(it) } catch (_: Exception) {}
        }
        registration = null
        clearPairingAdvertisement()
        discovery?.let { try { nsd.stopServiceDiscovery(it) } catch (_: Exception) {} }
        discovery = null
    }

    @Synchronized
    fun revoke() {
        synchronized(activeSockets) {
            activeSockets.toList().forEach { try { it.close() } catch (_: Exception) {} }
            activeSockets.clear()
        }
        pairingUntil = 0L
        pairingNonce = null
        pairingTarget = null
        pairingCode = null
        pairSessionSocket = null
        pairRejected = true
    }

    @Synchronized
    private fun advertise() {
        val listener = server ?: return
        if (registration != null) return
        val info = NsdServiceInfo().apply {
            serviceName = "nikucode-pausa"
            serviceType = SERVICE_TYPE
            port = listener.localPort
        }
        val callback = object : NsdManager.RegistrationListener {
            override fun onServiceRegistered(serviceInfo: NsdServiceInfo) {}
            override fun onRegistrationFailed(serviceInfo: NsdServiceInfo, errorCode: Int) {
                lastError = "Descubrimiento WiFi falló ($errorCode)"
                Log.e(LOG_TAG, "NSD registration failed: $errorCode")
            }
            override fun onServiceUnregistered(serviceInfo: NsdServiceInfo) {
                synchronized(this@LanPauseServer) {
                    if (registration === this) registration = null
                }
            }
            override fun onUnregistrationFailed(serviceInfo: NsdServiceInfo, errorCode: Int) {
                onServiceUnregistered(serviceInfo)
            }
        }
        registration = callback
        nsd.registerService(info, NsdManager.PROTOCOL_DNS_SD, callback)
    }

    @Synchronized
    private fun advertisePairingRequest() {
        val listener = server ?: return
        clearPairingAdvertisement()
        val nonce = pairingNonce ?: return
        val info = NsdServiceInfo().apply {
            serviceName = "nikucode-pausa-${nonce.take(8)}"
            serviceType = SERVICE_TYPE
            port = listener.localPort
            setAttribute("target", pairingTarget ?: "")
            setAttribute("nonce", nonce)
        }
        val callback = object : NsdManager.RegistrationListener {
            override fun onServiceRegistered(serviceInfo: NsdServiceInfo) {
                synchronized(this@LanPauseServer) {
                    if (pairingUntil <= System.currentTimeMillis()) clearPairingAdvertisement()
                }
            }
            override fun onRegistrationFailed(serviceInfo: NsdServiceInfo, errorCode: Int) {
                lastError = "No se pudo anunciar la solicitud ($errorCode)"
                Log.e(LOG_TAG, "Pairing request registration failed: $errorCode")
                synchronized(this@LanPauseServer) {
                    if (pairingRegistration === this) pairingRegistration = null
                }
            }
            override fun onServiceUnregistered(serviceInfo: NsdServiceInfo) {
                synchronized(this@LanPauseServer) {
                    if (pairingRegistration === this) pairingRegistration = null
                }
            }
            override fun onUnregistrationFailed(serviceInfo: NsdServiceInfo, errorCode: Int) {
                Log.e(LOG_TAG, "Pairing request unregistration failed: $errorCode")
                onServiceUnregistered(serviceInfo)
            }
        }
        pairingRegistration = callback
        nsd.registerService(info, NsdManager.PROTOCOL_DNS_SD, callback)
    }

    @Synchronized
    private fun clearPairingAdvertisement() {
        pairingRegistration?.let {
            try { nsd.unregisterService(it) } catch (_: Exception) {}
        }
        pairingRegistration = null
    }

    @Synchronized
    fun discoverDesktops(): List<Map<String, String>> {
        if (discovery == null) {
            val callback = object : NsdManager.DiscoveryListener {
                override fun onDiscoveryStarted(serviceType: String) {}
                override fun onStartDiscoveryFailed(serviceType: String, errorCode: Int) {
                    lastError = "No se pudo buscar Omarchy ($errorCode)"
                }
                override fun onStopDiscoveryFailed(serviceType: String, errorCode: Int) {}
                override fun onDiscoveryStopped(serviceType: String) {}
                override fun onServiceLost(serviceInfo: NsdServiceInfo) {
                    synchronized(this@LanPauseServer) { desktops.remove(serviceInfo.serviceName) }
                }
                override fun onServiceFound(serviceInfo: NsdServiceInfo) {
                    nsd.resolveService(serviceInfo, object : NsdManager.ResolveListener {
                        override fun onResolveFailed(info: NsdServiceInfo, code: Int) {}
                        override fun onServiceResolved(info: NsdServiceInfo) {
                            val id = info.attributes["id"]?.toString(Charsets.UTF_8) ?: return
                            if (!Regex("[0-9a-f]{32}").matches(id)) return
                            synchronized(this@LanPauseServer) { desktops[info.serviceName] = id }
                        }
                    })
                }
            }
            discovery = callback
            nsd.discoverServices(DESKTOP_TYPE, NsdManager.PROTOCOL_DNS_SD, callback)
        }
        return desktops.map { mapOf("name" to it.key, "id" to it.value) }
    }

    @Synchronized
    fun stopDiscovery() {
        discovery?.let { try { nsd.stopServiceDiscovery(it) } catch (_: Exception) {} }
        discovery = null
    }

    @Synchronized
    fun beginPair(desktopId: String): Boolean {
        if (!Regex("[0-9a-f]{32}").matches(desktopId) || desktopId !in desktops.values || server == null) return false
        pairingTarget = desktopId
        pairingNonce = ByteArray(16).also(random::nextBytes).joinToString("") { "%02x".format(it) }
        pairingUntil = System.currentTimeMillis() + 60_000L
        pairingCode = null
        phoneAccepted = false
        pairRejected = false
        stopDiscovery()
        advertisePairingRequest()
        return true
    }

    @Synchronized
    fun pairingState(): Map<String, Any?> {
        if (pairingUntil > 0 && System.currentTimeMillis() > pairingUntil) rejectPair()
        return mapOf("code" to pairingCode, "pending" to (pairingUntil > 0),
            "connected" to (System.currentTimeMillis() - lastSyncAt < 10_000L),
            "error" to lastError)
    }

    @Synchronized
    fun confirmPair(): Boolean {
        if (pairingCode == null || pairingUntil <= System.currentTimeMillis() || pairRejected) return false
        phoneAccepted = true
        return true
    }

    @Synchronized
    fun rejectPair() { revoke(); clearPairingAdvertisement() }

    private fun identityStore(): KeyStore {
        val store = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
        // Existing trusted peers keep the certificate they already pinned.
        if (preferences.getString("token", null) != null &&
            store.containsAlias(PREVIOUS_KEY_ALIAS) && !store.containsAlias(KEY_ALIAS)) {
            return store
        }
        if (!store.containsAlias(KEY_ALIAS)) {
            val now = System.currentTimeMillis()
            val spec = KeyGenParameterSpec.Builder(
                KEY_ALIAS,
                KeyProperties.PURPOSE_SIGN or KeyProperties.PURPOSE_VERIFY,
            )
                .setKeySize(2048)
                .setDigests(
                    KeyProperties.DIGEST_NONE,
                    KeyProperties.DIGEST_SHA256,
                    KeyProperties.DIGEST_SHA384,
                    KeyProperties.DIGEST_SHA512,
                )
                .setSignaturePaddings(
                    KeyProperties.SIGNATURE_PADDING_RSA_PKCS1,
                    KeyProperties.SIGNATURE_PADDING_RSA_PSS,
                )
                .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_NONE)
                .setCertificateSubject(X500Principal("CN=nikucode-pausa"))
                .setCertificateSerialNumber(java.math.BigInteger.valueOf(now))
                .setCertificateNotBefore(Date(now - 60_000L))
                .setCertificateNotAfter(Date(now + 10L * 365 * 24 * 60 * 60 * 1000))
                .build()
            KeyPairGenerator.getInstance(KeyProperties.KEY_ALGORITHM_RSA, "AndroidKeyStore")
                .apply { initialize(spec) }.generateKeyPair()
            preferences.edit().remove("token").commit()
        }
        for (oldAlias in listOf("nikucode_pause_lan_v1", PREVIOUS_KEY_ALIAS)) {
            if (store.containsAlias(oldAlias)) store.deleteEntry(oldAlias)
        }
        return store
    }

    private fun identityAlias(store: KeyStore): String =
        if (store.containsAlias(KEY_ALIAS)) KEY_ALIAS else PREVIOUS_KEY_ALIAS

    private fun handle(socket: SSLSocket) {
        socket.use {
            try {
                socket.soTimeout = 8000
                socket.startHandshake()
                val input = BufferedReader(InputStreamReader(socket.inputStream, Charsets.UTF_8))
                val output = socket.outputStream.bufferedWriter(Charsets.UTF_8)
                fun read(): JSONObject {
                    val line = StringBuilder()
                    while (true) {
                        val next = input.read()
                        if (next < 0) throw IllegalStateException("Disconnected")
                        if (next == '\n'.code) break
                        require(line.length < MAX_LINE) { "Message too large" }
                        line.append(next.toChar())
                    }
                    return JSONObject(line.toString())
                }
                fun send(value: String) {
                    output.write(value)
                    output.newLine()
                    output.flush()
                }
                val request = read()
                lastError = null
                when (request.optString("op")) {
                    "pairBegin" -> {
                        val desktopId = request.optString("id")
                        val nonce = request.optString("nonce")
                        val clientNonce = request.optString("clientNonce")
                        val store = identityStore()
                        val certificate = store.getCertificate(identityAlias(store)).encoded
                        synchronized(this) {
                            if (pairingUntil <= System.currentTimeMillis() ||
                                desktopId != pairingTarget || nonce != pairingNonce ||
                                !Regex("[0-9a-f]{32}").matches(clientNonce) || pairingCode != null) {
                                send("{\"error\":\"pairing_closed\"}")
                                return
                            }
                            val input = certificate + nonce.toByteArray(Charsets.UTF_8) +
                                clientNonce.toByteArray(Charsets.UTF_8)
                            pairingCode = MessageDigest.getInstance("SHA-256").digest(input)
                                .take(8).joinToString("") { "%02X".format(it) }
                            pairSessionSocket = socket
                        }
                        send("{\"ready\":true}")
                        socket.soTimeout = 65_000
                        val confirmation = read()
                        if (confirmation.optString("op") != "pairConfirm" ||
                            confirmation.optString("code") != pairingCode) {
                            rejectPair()
                            send("{\"error\":\"rejected\"}")
                            return
                        }
                        while (!phoneAccepted && !pairRejected && System.currentTimeMillis() < pairingUntil) {
                            Thread.sleep(150)
                        }
                        if (!phoneAccepted || pairRejected || System.currentTimeMillis() >= pairingUntil) {
                            send("{\"error\":\"rejected\"}")
                            return
                        }
                        val token = ByteArray(32).also(random::nextBytes)
                            .joinToString("") { "%02x".format(it) }
                        send(JSONObject(mapOf("token" to token)).toString())
                        val stored = read()
                        if (stored.optString("op") != "pairStored" ||
                            System.currentTimeMillis() >= pairingUntil) return
                        if (!preferences.edit().putString("token", token)
                                .putString("desktop_id", desktopId)
                                .putBoolean("enabled", true).commit()) {
                            send("{\"error\":\"store_failed\"}")
                            return
                        }
                        send("{\"paired\":true}")
                        synchronized(this) {
                            pairingUntil = 0L
                            pairingCode = null
                            pairSessionSocket = null
                            pairingNonce = null
                            pairingTarget = null
                            clearPairingAdvertisement()
                        }
                    }
                    "sync" -> {
                        val expected = preferences.getString("token", null) ?: return
                        val actual = request.optString("token")
                        if (actual.length != expected.length ||
                            !MessageDigest.isEqual(actual.toByteArray(), expected.toByteArray())) {
                            send("{\"error\":\"unauthorized\"}")
                            return
                        }
                        send(queue.snapshot())
                        val commit = read()
                        if (commit.optString("op") != "commit") return
                        send(queue.apply(commit.toString()))
                        lastSyncAt = System.currentTimeMillis()
                    }
                    "unpair" -> {
                        val expected = preferences.getString("token", null) ?: return
                        val actual = request.optString("token")
                        if (actual.length != expected.length ||
                            !MessageDigest.isEqual(actual.toByteArray(), expected.toByteArray())) return
                        if (preferences.edit().remove("token").remove("desktop_id")
                                .putBoolean("enabled", false).commit() && queue.clear()) {
                            send("{\"unpaired\":true}")
                            activity.stopService(android.content.Intent(activity, LanPauseService::class.java))
                        }
                    }
                    else -> send("{\"error\":\"unknown_operation\"}")
                }
            } catch (error: Exception) {
                lastError = "Conexión TLS falló: ${error.javaClass.simpleName}: ${error.message ?: "sin detalle"}"
                Log.e(LOG_TAG, "LAN TLS or protocol exchange failed", error)
            } finally {
                synchronized(this) {
                    if (pairSessionSocket === socket) rejectPair()
                }
            }
        }
    }

}
