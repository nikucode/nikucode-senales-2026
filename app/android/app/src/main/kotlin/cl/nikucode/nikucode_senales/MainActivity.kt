package cl.nikucode.nikucode_senales

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "cl.nikucode/reminders"
        private const val NOTIFICATION_CHANNEL_ID = "marea_pause_invites"
        private const val PERMISSION_REQUEST = 8402
        private const val EXTRA_REMINDER_ID = "nikucode.reminder_id"
    }

    private var bridge: MethodChannel? = null
    private var permissionResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        bridge = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        bridge?.setMethodCallHandler { call, result ->
            when (call.method) {
                "requestPermission" -> requestNotificationPermission(result)
                "showReminder" -> {
                    val id = call.arguments as? Int
                    if (id == null) result.error("invalid_id", "Missing reminder id", null)
                    else {
                        showReminder(id)
                        result.success(true)
                    }
                }
                "cancelReminders" -> {
                    notificationManager().cancelAll()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun requestNotificationPermission(result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            result.success(true)
            return
        }
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
            result.success(notificationsAllowed())
            return
        }
        if (checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED) {
            result.success(notificationsAllowed())
            return
        }
        permissionResult = result
        requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), PERMISSION_REQUEST)
    }

    @Suppress("DEPRECATION")
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != PERMISSION_REQUEST) return
        val result = permissionResult ?: return
        permissionResult = null
        result.success(
            grantResults.firstOrNull() == PackageManager.PERMISSION_GRANTED &&
                notificationsAllowed(),
        )
    }

    private fun notificationsAllowed(): Boolean =
        Build.VERSION.SDK_INT < Build.VERSION_CODES.N ||
            notificationManager().areNotificationsEnabled()

    private fun notificationManager(): NotificationManager =
        getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

    private fun showReminder(id: Int) {
        val manager = notificationManager()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            manager.createNotificationChannel(
                NotificationChannel(
                    NOTIFICATION_CHANNEL_ID,
                    "Invitaciones de pausa",
                    NotificationManager.IMPORTANCE_DEFAULT,
                ),
            )
        }

        val openApp = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP
            putExtra(EXTRA_REMINDER_ID, id)
        }
        val pendingIntentFlags = PendingIntent.FLAG_UPDATE_CURRENT or
            (if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                PendingIntent.FLAG_IMMUTABLE
            } else {
                0
            })
        val pendingIntent = PendingIntent.getActivity(
            this,
            id,
            openApp,
            pendingIntentFlags,
        )
        @Suppress("DEPRECATION")
        val notificationBuilder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, NOTIFICATION_CHANNEL_ID)
        } else {
            Notification.Builder(this)
        }
        val notification = notificationBuilder
            .setSmallIcon(applicationInfo.icon)
            .setContentTitle("¿Un momento para moverte?")
            .setContentText("Hay una propuesta breve. Tú eliges el momento.")
            .setAutoCancel(true)
            .setContentIntent(pendingIntent)
            .build()

        manager.notify(id, notification)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        if (intent.hasExtra(EXTRA_REMINDER_ID)) {
            bridge?.invokeMethod("reminderOpened", intent.getIntExtra(EXTRA_REMINDER_ID, -1))
        }
    }
}
