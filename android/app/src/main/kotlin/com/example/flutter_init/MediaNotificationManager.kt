package com.example.flutter_init

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat

// MediaNotificationManager: 通知の生成/更新を担当（段階1はプレースホルダ）
object MediaNotificationManager {
    fun buildPlaceholderNotification(context: Context) =
        NotificationCompat.Builder(context, MediaService.CHANNEL_ID)
            .setSmallIcon(context.applicationInfo.icon)
            .setContentTitle("音声メモを再生中")
            .setContentText("ロック画面/通知から操作（段階1: 準備）")
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .build()
}