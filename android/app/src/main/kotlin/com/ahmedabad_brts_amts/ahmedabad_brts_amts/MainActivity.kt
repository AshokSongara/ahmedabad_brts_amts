package com.ahmedabad_brts_amts.ahmedabad_brts_amts

import android.content.Intent
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "nativeChannel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result? ->
                if (call.method == "setToast") {
                    val myText = call.argument<String>("myText")
                    this.startActivity(Intent(this,com.ahmedabad_brts_amts.ahmedabad_brts_amts.View.MainActivity::class.java))
//                    setText(myText)
                }
            }
        startActivity(FlutterActivity.withCachedEngine(CHANNEL).build(this));
    }

    private fun setText(myText: String?) {
        Toast.makeText(this, myText,Toast.LENGTH_LONG).show()

    }
}
