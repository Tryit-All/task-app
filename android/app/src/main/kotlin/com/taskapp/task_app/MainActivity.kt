package com.taskapp.task_app

import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.taskapp.task_app/sos"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        intent.getStringExtra("sosMessage")?.let { sosMessage ->
            Log.d("MainActivity", "Received SOS Message: $sosMessage")
            MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
                .invokeMethod("sosMessage", sosMessage)
        } ?: run {
            Log.d("MainActivity", "No SOS Message received")
        }
    }

}
