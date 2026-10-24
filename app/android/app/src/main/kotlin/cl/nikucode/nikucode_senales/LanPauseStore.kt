package cl.nikucode.nikucode_senales

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/** Data used by the LAN service while Flutter is not running. */
class LanPauseStore(context: Context) {
    companion object { private val lock = Any() }
    private val preferences = context.getSharedPreferences("nikucode_lan_queue_v1", Context.MODE_PRIVATE)

    @Synchronized
    fun schedules(): JSONArray = synchronized(lock) {
        JSONArray(preferences.getString("schedules", "[]"))
    }

    @Synchronized
    fun events(): JSONArray = synchronized(lock) {
        JSONArray(preferences.getString("events", "[]"))
    }

    @Synchronized
    fun enqueue(schedule: JSONObject): Int = synchronized(lock) {
        val list = schedules()
        if (list.length() >= 32) throw IllegalStateException("Demasiadas pausas pendientes")
        if (schedule.optString("id").isEmpty() || schedule.optString("dueAt").isEmpty()) {
            throw IllegalArgumentException("Solicitud incompleta")
        }
        val invitationId = schedule.optLong("notificationId", 0L)
        val dueAtMs = schedule.optLong("dueAtMs", 0L)
        if (invitationId != 0L && dueAtMs <= 0L) {
            throw IllegalArgumentException("Hora del aviso incompleta")
        }
        list.put(schedule)
        val edit = preferences.edit().putString("schedules", list.toString())
        if (invitationId > 0L) {
            edit.putString("local_reminder", JSONObject()
                .put("notificationId", invitationId)
                .put("dueAtMs", dueAtMs).toString())
        }
        check(edit.commit())
        list.length()
    }

    @Synchronized
    fun dueLocalReminder(nowMs: Long): Long? = synchronized(lock) {
        val raw = preferences.getString("local_reminder", null) ?: return@synchronized null
        val reminder = JSONObject(raw)
        val id = reminder.optLong("notificationId", 0L)
        val dueAt = reminder.optLong("dueAtMs", 0L)
        if (id <= 0L || dueAt <= 0L) return@synchronized null
        if (nowMs - dueAt > 30L * 60L * 1000L) {
            preferences.edit().remove("local_reminder").commit()
            return@synchronized null
        }
        if (dueAt > nowMs) null else id
    }

    @Synchronized
    fun markLocalDelivered(id: Long): Boolean = synchronized(lock) {
        val raw = preferences.getString("local_reminder", null) ?: return@synchronized true
        if (JSONObject(raw).optLong("notificationId", 0L) != id) return@synchronized true
        preferences.edit().remove("local_reminder").commit()
    }

    @Synchronized
    fun importLegacy(raw: String): Int = synchronized(lock) {
        val existing = schedules()
        val ids = (0 until existing.length()).map { existing.getJSONObject(it).optString("id") }.toSet()
        val old = JSONArray(raw)
        for (index in 0 until old.length()) {
            val item = old.optJSONObject(index) ?: continue
            if (item.optString("id").isNotEmpty() && item.optString("dueAt").isNotEmpty() &&
                item.optString("id") !in ids && existing.length() < 32) existing.put(item)
        }
        check(preferences.edit().putString("schedules", existing.toString()).commit())
        existing.length()
    }

    @Synchronized
    fun cancel(): Boolean = synchronized(lock) {
        val next = preferences.getLong("cancel_generation", 0L) + 1L
        preferences.edit().putString("schedules", "[]")
            .remove("local_reminder")
            .putLong("cancel_generation", next).commit()
    }

    @Synchronized
    fun snapshot(): String = synchronized(lock) {
        val local = preferences.getString("local_reminder", null)
        JSONObject().put("schedules", schedules())
            .put("cancelGeneration", preferences.getLong("cancel_generation", 0L))
            .put("localReminder", if (local == null) JSONObject.NULL else JSONObject(local))
            .toString()
    }

    @Synchronized
    fun apply(raw: String): String = synchronized(lock) {
        val commit = JSONObject(raw)
        val removed = mutableSetOf<String>()
        for (name in listOf("accepted", "expired")) {
            val values = commit.optJSONArray(name) ?: JSONArray()
            for (index in 0 until values.length()) removed.add(values.optString(index))
        }
        val current = schedules()
        val remaining = JSONArray()
        for (index in 0 until current.length()) {
            val item = current.optJSONObject(index) ?: continue
            if (item.optString("id") !in removed) remaining.put(item)
        }
        val known = events()
        val seen = (0 until known.length()).map { known.getJSONObject(it).optString("id") }.toMutableSet()
        val incoming = commit.optJSONArray("events") ?: JSONArray()
        val acknowledged = JSONArray()
        var postponedLocal: JSONObject? = null
        val generation = preferences.getLong("cancel_generation", 0L)
        for (index in 0 until incoming.length()) {
            val event = incoming.optJSONObject(index) ?: continue
            val id = event.optString("id")
            if (id.isEmpty() || event.optString("kind").isEmpty() || event.optString("at").isEmpty()) continue
            if (id !in seen) {
                known.put(event)
                seen.add(id)
                if (event.optString("kind") == "postponed" &&
                    event.optLong("generation", -1L) == generation) {
                    val nextId = event.optLong("notificationId", 0L)
                    val dueAtMs = event.optLong("dueAtMs", 0L)
                    if (nextId > 0L && dueAtMs > 0L) {
                        postponedLocal = JSONObject().put("notificationId", nextId)
                            .put("dueAtMs", dueAtMs)
                    }
                }
            }
            acknowledged.put(id)
        }
        if (known.length() > 1024) throw IllegalStateException("Demasiados resultados pendientes")
        val edit = preferences.edit().putString("schedules", remaining.toString())
            .putString("events", known.toString())
        if (postponedLocal != null) {
            edit.putString("local_reminder", postponedLocal.toString())
        }
        check(edit.commit())
        JSONObject().put("acknowledged", acknowledged).toString()
    }

    @Synchronized
    fun acknowledge(ids: Set<String>): Boolean = synchronized(lock) {
        val current = events()
        val remaining = JSONArray()
        for (index in 0 until current.length()) {
            val event = current.optJSONObject(index) ?: continue
            if (event.optString("id") !in ids) remaining.put(event)
        }
        preferences.edit().putString("events", remaining.toString()).commit()
    }

    @Synchronized
    fun clear(): Boolean = synchronized(lock) { preferences.edit().clear().commit() }
}
