package cl.nikucode.nikucode_senales

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.AppOpsManager
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.os.Build
import android.os.Process
import android.provider.Settings
import java.io.ByteArrayOutputStream
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "cl.nikucode/reminders"
        private const val USAGE_CHANNEL = "cl.nikucode/usage"
        private const val LAN_CHANNEL = "cl.nikucode/lan"
        private const val NOTIFICATION_CHANNEL_ID = "marea_pause_invites"
        private const val PERMISSION_REQUEST = 8402
        private const val EXTRA_REMINDER_ID = "nikucode.reminder_id"
        private const val INVITATION_PREFS = "nikucode.reminder_state"
        private const val ACTIVE_INVITATION_ID = "active_invitation_id"
    }

    private var bridge: MethodChannel? = null
    private var usageBridge: MethodChannel? = null
    private var lanBridge: MethodChannel? = null
    private var lanServer: LanPauseServer? = null
    private var permissionResult: MethodChannel.Result? = null
    private var pendingReminderId: Long? = null
    private var pendingReminderDelivery = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        bridge = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        bridge?.setMethodCallHandler { call, result ->
            try {
                when (call.method) {
                    "requestPermission" -> requestNotificationPermission(result)
                    "showReminder" -> {
                        val id = when (val value = call.arguments) {
                            is Long -> value
                            is Int -> value.toLong()
                            else -> null
                        }
                        if (id == null || id <= 0L) {
                            result.error("invalid_id", "Missing reminder id", null)
                        } else {
                            try {
                                showReminder(id)
                                result.success(true)
                            } catch (error: Exception) {
                                result.error("show_failed", error.message, null)
                            }
                        }
                    }
                    "cancelReminders" -> {
                        invalidatePendingOpen()
                        if (!clearActiveInvitation()) {
                            result.error(
                                "cancel_failed",
                                "Could not invalidate the invitation",
                                null,
                            )
                        } else {
                            notificationManager().cancelAll()
                            result.success(true)
                        }
                    }
                    "consumeInitialReminder" -> {
                        val pending = pendingReminderId
                        if (pending != null) {
                            pendingReminderId = null
                            result.success(pending)
                        } else {
                            val source = intent
                            val id = consumeValidInvitation(source)
                            clearReminderExtra(source)
                            result.success(id)
                        }
                    }
                    else -> result.notImplemented()
                }
            } catch (error: Exception) {
                result.error("reminder_operation_failed", error.message, null)
            }
        }
        usageBridge = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, USAGE_CHANNEL)
        usageBridge?.setMethodCallHandler { call, result ->
            when (call.method) {
                "hasAccess" -> result.success(hasUsageAccess())
                "openAccessSettings" -> {
                    try {
                        startActivity(Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS))
                        result.success(null)
                    } catch (error: Exception) {
                        result.error("settings_unavailable", error.message, null)
                    }
                }
                "loadWeek" -> {
                    val start = (call.arguments as? Number)?.toLong()
                    if (start == null) {
                        result.error("invalid_week", "Missing week start", null)
                    } else if (!hasUsageAccess()) {
                        result.error("usage_access_denied", "Usage access is not enabled", null)
                    } else {
                        Thread {
                            try {
                                val days = loadUsageWeek(start)
                                runOnUiThread { result.success(days) }
                            } catch (error: Exception) {
                                runOnUiThread { result.error("usage_unavailable", error.message, null) }
                            }
                        }.start()
                    }
                }
                else -> result.notImplemented()
            }
        }
        lanBridge = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LAN_CHANNEL)
        lanServer = LanPauseServer(this, lanBridge!!)
        lanBridge?.setMethodCallHandler { call, result ->
            when (call.method) {
                "pairingInfo" -> {
                    try {
                        result.success(lanServer?.pairingInfo())
                    } catch (error: Exception) {
                        result.error("pairing_unavailable", error.message, null)
                    }
                }
                "isPaired" -> result.success(
                    getSharedPreferences("nikucode_lan_v1", Context.MODE_PRIVATE)
                        .getString("token", null) != null,
                )
                "unpair" -> {
                    val removed = getSharedPreferences("nikucode_lan_v1", Context.MODE_PRIVATE)
                        .edit().remove("token").commit()
                    if (removed) lanServer?.revoke()
                    result.success(removed)
                }
                else -> result.notImplemented()
            }
        }
        deliverPendingReminder()
    }

    override fun onStart() {
        super.onStart()
        lanServer?.start()
    }

    override fun onStop() {
        lanServer?.stop()
        super.onStop()
    }

    private fun hasUsageAccess(): Boolean {
        val ops = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        return ops.checkOpNoThrow(
            AppOpsManager.OPSTR_GET_USAGE_STATS,
            Process.myUid(),
            packageName,
        ) == AppOpsManager.MODE_ALLOWED
    }

    private fun loadUsageWeek(startMillis: Long): List<Map<String, Any>> {
        val manager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val calendar = Calendar.getInstance().apply {
            timeInMillis = startMillis
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }
        val formatter = SimpleDateFormat("yyyy-MM-dd", Locale.ROOT)
        val now = System.currentTimeMillis()
        return (0 until 7).map {
            val start = calendar.timeInMillis
            val date = formatter.format(calendar.time)
            calendar.add(Calendar.DAY_OF_MONTH, 1)
            val end = calendar.timeInMillis
            val byPackage = mutableMapOf<String, Long>()
            if (start < now) {
                val stats = manager.queryUsageStats(
                    UsageStatsManager.INTERVAL_DAILY,
                    start,
                    minOf(end, now),
                ) ?: throw IllegalStateException("Usage data unavailable while device is locked")
                for (usage in stats) {
                    if (usage.firstTimeStamp < start || usage.firstTimeStamp >= end) continue
                    if (usage.totalTimeInForeground <= 0) continue
                    byPackage[usage.packageName] =
                        (byPackage[usage.packageName] ?: 0L) + usage.totalTimeInForeground
                }
            }
            val apps = byPackage.entries.sortedByDescending { it.value }.map { (name, millis) ->
                mapOf<String, Any>(
                    "package" to name,
                    "label" to applicationLabel(name),
                    "milliseconds" to millis,
                    "icon" to applicationIcon(name),
                )
            }
            mapOf("date" to date, "apps" to apps)
        }
    }

    private fun applicationLabel(name: String): String = try {
        @Suppress("DEPRECATION")
        packageManager.getApplicationLabel(packageManager.getApplicationInfo(name, 0)).toString()
    } catch (_: Exception) {
        name
    }

    private fun applicationIcon(name: String): ByteArray = try {
        val drawable = packageManager.getApplicationIcon(name)
        val bitmap = Bitmap.createBitmap(48, 48, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, 48, 48)
        drawable.draw(canvas)
        val stream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 90, stream)
        bitmap.recycle()
        stream.toByteArray()
    } catch (_: Exception) {
        byteArrayOf()
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

    private fun showReminder(id: Long) {
        invalidatePendingOpen()
        val manager = notificationManager()
        if (!notificationsAllowed()) {
            throw IllegalStateException("Notifications are unavailable or permission was denied")
        }
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
        val notificationId = platformNotificationId(id)
        val pendingIntentFlags = PendingIntent.FLAG_UPDATE_CURRENT or
            (if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                PendingIntent.FLAG_IMMUTABLE
            } else {
                0
            })
        val pendingIntent = PendingIntent.getActivity(
            this,
            notificationId,
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

        // Persist only this opaque invitation ID, never its timer or reminder
        // preference. A tap is accepted only when Android returns this ID.
        if (!invitationPreferences().edit().putLong(ACTIVE_INVITATION_ID, id).commit()) {
            throw IllegalStateException("Could not record the active invitation ID")
        }
        try {
            manager.notify(notificationId, notification)
        } catch (error: Exception) {
            clearActiveInvitation()
            throw error
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        try {
            val id = consumeValidInvitation(intent) ?: return
            pendingReminderId = id
            deliverPendingReminder()
        } catch (error: Exception) {
            pendingReminderId = null
            bridge?.invokeMethod("reminderOpenFailed", null)
        } finally {
            clearReminderExtra(intent)
        }
    }

    private fun invalidatePendingOpen() {
        pendingReminderId = null
        clearReminderExtra(intent)
    }

    private fun deliverPendingReminder() {
        val id = pendingReminderId ?: return
        val activeBridge = bridge ?: return
        if (pendingReminderDelivery) return
        pendingReminderDelivery = true
        activeBridge.invokeMethod("reminderOpened", id, object : MethodChannel.Result {
            override fun success(result: Any?) {
                if (pendingReminderId == id) pendingReminderId = null
                finishPendingReminderDelivery(id)
            }

            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                finishPendingReminderDelivery(id)
            }

            override fun notImplemented() {
                finishPendingReminderDelivery(id)
            }
        })
    }

    private fun finishPendingReminderDelivery(id: Long) {
        pendingReminderDelivery = false
        if (pendingReminderId != null && pendingReminderId != id) {
            deliverPendingReminder()
        }
    }

    private fun consumeValidInvitation(source: Intent): Long? {
        if (!source.hasExtra(EXTRA_REMINDER_ID)) return null
        val id = source.getLongExtra(EXTRA_REMINDER_ID, 0L)
        if (id <= 0L) return null

        val preferences = invitationPreferences()
        if (preferences.getLong(ACTIVE_INVITATION_ID, 0L) != id) return null
        if (!notificationsAllowed()) {
            if (!clearActiveInvitation()) {
                throw IllegalStateException("Could not invalidate the active invitation ID")
            }
            notificationManager().cancel(platformNotificationId(id))
            return null
        }
        if (!preferences.edit().remove(ACTIVE_INVITATION_ID).commit()) {
            throw IllegalStateException("Could not consume the active invitation ID")
        }

        notificationManager().cancel(platformNotificationId(id))
        return id
    }

    private fun clearReminderExtra(source: Intent) {
        if (source.hasExtra(EXTRA_REMINDER_ID)) {
            setIntent(Intent(source).apply { removeExtra(EXTRA_REMINDER_ID) })
        }
    }

    private fun invitationPreferences() =
        getSharedPreferences(INVITATION_PREFS, Context.MODE_PRIVATE)

    private fun clearActiveInvitation(): Boolean =
        invitationPreferences().edit().remove(ACTIVE_INVITATION_ID).commit()

    private fun platformNotificationId(id: Long): Int =
        (id xor (id ushr 32)).toInt() and Int.MAX_VALUE

    override fun onDestroy() {
        bridge = null
        usageBridge = null
        super.onDestroy()
    }
}
