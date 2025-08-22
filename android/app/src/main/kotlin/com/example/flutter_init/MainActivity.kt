package com.example.flutter_init

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// MainActivity: Flutter側とAndroidネイティブのブリッジ（MethodChannel）
// 段階1ではスタブ実装（NO-OP）として、将来的にMediaService/Notificationへ連携します。
class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flutter_init/media_controls"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                // 通知の表示/更新（タイトル、再生状態、位置/長さ）
                "showOrUpdateNotification" -> {
                    // 段階1: 何もしない（将来 MediaService + Notification に委譲）
                    result.success(null)
                }
                // 通知の非表示
                "hideNotification" -> {
                    // 段階1: 何もしない
                    result.success(null)
                }
                // メディアボタンのコールバック登録
                "registerCallbacks" -> {
                    // 段階1: 何もしない
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 現時点では特別な初期化は不要
    }
}
