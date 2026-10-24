package cl.nikucode.nikucode_senales

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.os.Handler
import android.os.Looper
import android.util.Log

/** User-visible LAN endpoint; survives the Flutter activity going away. */
class LanPauseService : Service() {
    companion object {
        private const val CHANNEL_ID = "nikucode_lan_connection"
        private const val NOTIFICATION_ID = 46274
        const val ACTION_STOP = "cl.nikucode.lan.STOP"
        @Volatile var instance: LanPauseService? = null
            private set

        fun start(context: Context) {
            val preferences = context.getSharedPreferences("nikucode_lan_v1", Context.MODE_PRIVATE)
            if (preferences.getString("token", null) != null) {
                preferences.edit().putBoolean("enabled", true).apply()
            }
            val intent = Intent(context, LanPauseService::class.java)
            if (Build.VERSION.SDK_INT >= 26) context.startForegroundService(intent)
            else context.startService(intent)
        }
    }

    lateinit var endpoint: LanPauseServer
        private set
    lateinit var queue: LanPauseStore
        private set
    private val signalHandler = Handler(Looper.getMainLooper())
    private val signalCheck = object : Runnable {
        override fun run() {
            try {
                val due = queue.dueLocalReminder(System.currentTimeMillis())
                if (due != null) {
                    try {
                        MainActivity.publishReminder(this@LanPauseService, due)
                    } catch (error: Exception) {
                        Log.e("NikucodeLan", "Could not show shared reminder", error)
                    } finally {
                        queue.markLocalDelivered(due)
                    }
                }
            } catch (error: Exception) {
                Log.e("NikucodeLan", "Could not check shared reminder", error)
            } finally {
                signalHandler.postDelayed(this, 1000L)
            }
        }
    }

    override fun onCreate() {
        super.onCreate()
        queue = LanPauseStore(this)
        endpoint = LanPauseServer(this, queue)
        instance = this
        val manager = getSystemService(NotificationManager::class.java)
        if (Build.VERSION.SDK_INT >= 26) {
            manager.createNotificationChannel(NotificationChannel(
                CHANNEL_ID, "Conexión con Omarchy", NotificationManager.IMPORTANCE_LOW,
            ))
        }
        val open = PendingIntent.getActivity(this, 0, Intent(this, MainActivity::class.java),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val stop = PendingIntent.getService(this, 1,
            Intent(this, LanPauseService::class.java).setAction(ACTION_STOP),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val builder = if (Build.VERSION.SDK_INT >= 26) Notification.Builder(this, CHANNEL_ID)
            else Notification.Builder(this)
        val notification = builder
            .setSmallIcon(android.R.drawable.ic_popup_sync)
            .setContentTitle("nikucode · Omarchy")
            .setContentText("Conexión local activa para tus pausas")
            .setContentIntent(open)
            .addAction(android.R.drawable.ic_media_pause, "Detener conexión", stop)
            .setOngoing(true)
            .build()
        if (Build.VERSION.SDK_INT >= 34) {
            startForeground(NOTIFICATION_ID, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_CONNECTED_DEVICE)
        } else startForeground(NOTIFICATION_ID, notification)
        endpoint.start()
        signalHandler.post(signalCheck)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == ACTION_STOP) {
            getSharedPreferences("nikucode_lan_v1", MODE_PRIVATE).edit().putBoolean("enabled", false).apply()
            stopSelf()
            return START_NOT_STICKY
        }
        return START_STICKY
    }

    override fun onDestroy() {
        signalHandler.removeCallbacks(signalCheck)
        endpoint.stop()
        instance = null
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null
}

class LanPauseBootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        if (intent?.action != Intent.ACTION_BOOT_COMPLETED) return
        if (context.getSharedPreferences("nikucode_lan_v1", Context.MODE_PRIVATE)
                .getBoolean("enabled", false)) {
            try { LanPauseService.start(context) } catch (_: Exception) {
                // The app explains how to reactivate if Android disallows startup.
            }
        }
    }
}
