package dev.lucas.monigate_app

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "dev.lucas.tracing").setMethodCallHandler { call, result ->
            when (call.method) {
                "startTracingService" -> {
                    startService(Intent(this, BleService::class.java))
                    result.success("Started!")
                }
                "stopTracingService" -> {
                    stopService(Intent(this, BleService::class.java))
                    result.success("Stopped!")
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
