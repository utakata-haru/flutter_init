package com.example.flutter_init

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder

// MediaService: 将来のメディア通知・ロック画面コントロールを扱う前景サービス
// 段階1では起動/停止のスケルトンのみ実装します。
class MediaService : Service() {
    companion object {
        const val CHANNEL_ID = "voice_memo_media"
        const val CHANNEL_NAME = "Voice Memo Media"
        const val NOTIFICATION_ID = 1001

        const val ACTION_START = "com.example.flutter_init.action.START"
        const val ACTION_STOP = "com.example.flutter_init.action.STOP"
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_START -> {
                // 段階1: プレースホルダの常駐通知を表示
                val notification = MediaNotificationManager.buildPlaceholderNotification(this)
                startForeground(NOTIFICATION_ID, notification)
            }
            ACTION_STOP -> {
                stopForeground(STOP_FOREGROUND_REMOVE)
                stopSelf()
            }
            else -> {
                // 何もしない
            }
        }
        return START_NOT_STICKY
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                CHANNEL_NAME,
                NotificationManager.IMPORTANCE_LOW
            )
            val nm = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            nm.createNotificationChannel(channel)
        }
    }
}