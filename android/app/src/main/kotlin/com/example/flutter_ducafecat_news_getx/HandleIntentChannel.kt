package com.example.flutter_ducafecat_news_getx

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.widget.Toast
import androidx.core.app.ActivityCompat.startActivityForResult
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class HandleIntentChannel(binaryMessage: BinaryMessenger, private val context: Context) :
    MethodChannel.MethodCallHandler {

    private val handleIntentChannel: MethodChannel =
        MethodChannel(binaryMessage, "handle_intent_channel")

    init {
        handleIntentChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getIntentMessage" -> {
                result.success(true)
            }

            "openApp" -> {
                val intent = Intent(context, MainActivity::class.java)
                intent.flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
                context.startActivity(intent)
            }

            "showToast" -> {
                Toast.makeText(context, "1234", Toast.LENGTH_SHORT).show()
            }

            "overlayAuth" -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    val intent = Intent(
                        Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                        Uri.parse("package:${context.packageName}")
                    )
                    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    context.startActivity(intent)
                }
            }
        }
    }


    fun sendMessage(type: String = "origin_message", params: Any? = "") {
        val p: String? = params?.toString()
        handleIntentChannel.invokeMethod(
            "onListener", mapOf(
                "type" to type,
                "params" to mapOf(
                    "route" to p
                )
            )
        )
    }
}