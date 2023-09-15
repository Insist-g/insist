package com.example.flutter_ducafecat_news_getx

import android.annotation.SuppressLint
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    companion object {
        @SuppressLint("StaticFieldLeak")
        lateinit var handleIntentChannel: HandleIntentChannel
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handlerIntent();
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        // 注册Intent处理channel
        handleIntentChannel =
            HandleIntentChannel(flutterEngine.dartExecutor.binaryMessenger, context)
    }

    private fun handlerIntent() {
        handleIntentChannel.sendMessage("type", "route")
    }
}
