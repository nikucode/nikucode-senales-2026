package cl.nikucode.nikucode_senales

import android.content.Context
import android.net.nsd.NsdManager
import android.net.nsd.NsdServiceInfo
import android.security.keystore.KeyGenParameterSpec
import android.security.keystore.KeyProperties
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.Inet4Address
import java.net.NetworkInterface
import java.util.Collections
import java.security.KeyPairGenerator
import java.security.KeyStore
import java.security.MessageDigest
import java.security.SecureRandom
import java.util.Date
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Semaphore
import java.util.concurrent.TimeUnit
import javax.net.ssl.KeyManagerFactory
import javax.net.ssl.SSLContext
import javax.net.ssl.SSLServerSocket
import javax.net.ssl.SSLSocket
import javax.security.auth.x500.X500Principal
import org.json.JSONObject

/** Foreground-only TLS endpoint. The desktop always opens the LAN connection. */
class LanPauseServer(
    private val activity: MainActivity,
    private val channel: MethodChannel,
) {
    companion object {
        private const val KEY_ALIAS = "nikucode_pause_lan_v2"
        private const val LOG_TAG = "NikucodeLan"
        private const val SERVICE_TYPE = "_nikucode-pause._tcp."
        private const val MAX_LINE = 65536
        private const val LISTEN_PORT = 46274
    }

    private val preferences = activity.getSharedPreferences("nikucode_lan_v1", Context.MODE_PRIVATE)
    private val nsd = activity.getSystemService(Context.NSD_SERVICE) as NsdManager
    private var server: SSLServerSocket? = null
    private var registration: NsdManager.RegistrationListener? = null
    private var pairingUntil = 0L
    private var pairingPin: String? = null
    private val random = SecureRandom()
    private val connections = Semaphore(4)
    private val activeSockets = Collections.synchronizedSet(mutableSetOf<SSLSocket>())
    @Volatile private var lastError: String? = null

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
                override fun onServiceUnregistered(serviceInfo: NsdServiceInfo) {}
                override fun onUnregistrationFailed(serviceInfo: NsdServiceInfo, errorCode: Int) {}
            }
            registration = callback
            nsd.registerService(info, NsdManager.PROTOCOL_DNS_SD, callback)
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
                        // Check whether the activity is still foreground.
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
    }

    @Synchronized
    fun revoke() {
        synchronized(activeSockets) {
            activeSockets.toList().forEach { try { it.close() } catch (_: Exception) {} }
            activeSockets.clear()
        }
        pairingUntil = 0L
        pairingPin = null
    }

    @Synchronized
    fun pairingInfo(): Map<String, Any>? {
        val listener = server ?: return null
        pairingUntil = System.currentTimeMillis() + 120_000L
        val pinBytes = ByteArray(8).also(random::nextBytes)
        pairingPin = pinBytes.joinToString("") { "%02X".format(it) }
        val certificate = identityStore().getCertificate(KEY_ALIAS)
        val digest = MessageDigest.getInstance("SHA-256").digest(certificate.encoded)
        val code = digest.take(8).joinToString("") { "%02X".format(it) }
        val addresses = Collections.list(NetworkInterface.getNetworkInterfaces())
            .filter { it.isUp && !it.isLoopback }
            .sortedBy { if (it.name.startsWith("wlan")) 0 else 1 }
            .flatMap { Collections.list(it.inetAddresses) }
            .filterIsInstance<Inet4Address>()
            .filter { it.isSiteLocalAddress && !it.isLoopbackAddress }
            .map { it.hostAddress ?: "" }
        return mapOf(
            "address" to (addresses.firstOrNull() ?: ""),
            "port" to listener.localPort,
            "code" to code,
            "pin" to pairingPin!!,
            "error" to (lastError ?: ""),
        )
    }

    @Synchronized
    private fun consumePairing(pin: String): String? {
        val expected = pairingPin ?: return null
        if (System.currentTimeMillis() > pairingUntil || pairingUntil == 0L ||
            pin.length != expected.length ||
            !MessageDigest.isEqual(pin.toByteArray(), expected.toByteArray())) return null
        val bytes = ByteArray(32).also(random::nextBytes)
        val token = bytes.joinToString("") { "%02x".format(it) }
        if (!preferences.edit().putString("token", token).commit()) return null
        pairingUntil = 0L
        pairingPin = null
        return token
    }

    private fun identityStore(): KeyStore {
        val store = KeyStore.getInstance("AndroidKeyStore").apply { load(null) }
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
                .setCertificateSubject(X500Principal("CN=nikucode-pausa"))
                .setCertificateSerialNumber(java.math.BigInteger.valueOf(now))
                .setCertificateNotBefore(Date(now - 60_000L))
                .setCertificateNotAfter(Date(now + 10L * 365 * 24 * 60 * 60 * 1000))
                .build()
            KeyPairGenerator.getInstance(KeyProperties.KEY_ALGORITHM_RSA, "AndroidKeyStore")
                .apply { initialize(spec) }.generateKeyPair()
            preferences.edit().remove("token").commit()
            if (store.containsAlias("nikucode_pause_lan_v1")) {
                store.deleteEntry("nikucode_pause_lan_v1")
            }
        }
        return store
    }

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
                    "pair" -> {
                        val token = consumePairing(request.optString("pin"))
                        if (token == null) {
                            send("{\"error\":\"pairing_closed\"}")
                            return
                        }
                        send(JSONObject(mapOf("token" to token)).toString())
                    }
                    "sync" -> {
                        val expected = preferences.getString("token", null) ?: return
                        val actual = request.optString("token")
                        if (actual.length != expected.length ||
                            !MessageDigest.isEqual(actual.toByteArray(), expected.toByteArray())) {
                            send("{\"error\":\"unauthorized\"}")
                            return
                        }
                        send(askFlutter("lanSnapshot", null) ?: "{\"error\":\"app_unavailable\"}")
                        val commit = read()
                        if (commit.optString("op") != "commit") return
                        send(askFlutter("lanApply", commit.toString()) ?: "{\"error\":\"app_unavailable\"}")
                    }
                    else -> send("{\"error\":\"unknown_operation\"}")
                }
            } catch (error: Exception) {
                lastError = "Conexión TLS falló: ${error.javaClass.simpleName}: ${error.message ?: "sin detalle"}"
                Log.e(LOG_TAG, "LAN TLS or protocol exchange failed", error)
            }
        }
    }

    private fun askFlutter(method: String, argument: String?): String? {
        val latch = CountDownLatch(1)
        var answer: String? = null
        activity.runOnUiThread {
            channel.invokeMethod(method, argument, object : MethodChannel.Result {
                override fun success(result: Any?) { answer = result as? String; latch.countDown() }
                override fun error(code: String, message: String?, details: Any?) { latch.countDown() }
                override fun notImplemented() { latch.countDown() }
            })
        }
        latch.await(5, TimeUnit.SECONDS)
        return answer
    }
}
