package dev.lucas.monigate_app

import android.app.ActivityManager
import android.content.Intent
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "dev.lucas.tracing"
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startTracingService" -> {
                    startService(Intent(this, BleService::class.java))
                    result.success("Started!")
                }
                "stopTracingService" -> {
                    stopService(Intent(this, BleService::class.java))
                    result.success("Stopped!")
                }
                "getTracingServiceStatus" -> {
                    val manager = ContextCompat.getSystemService(context, ActivityManager::class.java)


                    val runningServices = manager?.getRunningServices(Int.MAX_VALUE)

                    val isRunningTracingService = runningServices?.any { runningServiceInfo ->
                        runningServiceInfo.service.className == BleService::class.java.name
                    } ?: false

                    result.success(if (isRunningTracingService) "On" else "Off")


//                    manager?.let {
//                        result.success(it.getRunningServices(Int.MAX_VALUE))
//                        val isRunningTracing = it.getRunningServices(Int.MAX_VALUE).any { runningServiceInfo ->
//                            runningServiceInfo.service.className.contains(BleService::class.java.name)
//                        }
//
//                        result.success(
//                            if (isRunningTracing) "On" else "Off"
//                        )
//
//                    } ?: run {
//                        Log.d("null manager", "configureFlutterEngine: ")
//                        result.success("Off because null")
//                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
