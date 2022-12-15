package com.example.native_example
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context          
import android.Manifest
import android.content.ContentResolver
import io.flutter.plugin.common.MethodChannel.Result;

class MainActivity: FlutterActivity() {


    private val SHARED_CHANNEL = "shared_method_channel"
    private val BOX_NAME = "FlutterSharedPreferences"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        MethodChannel(messenger, SHARED_CHANNEL)
            .setMethodCallHandler{
                call,result ->
                    when(call.method){
                        "getSharedValue" -> {
                            val key = call.argument<String?>("key")
                            val value = getSharedValue(key)
                            result.success(value)
                         }
                         "setSharedValue" -> {
                             val key = call.argument<String?>("key")
                             val value = call.argument<String?>("value")
                             setSharedValue(key,value)
                             result.success(null)
                          }
                }       
        }
    }

    
    private fun getSharedValue(key: String?):String?{
      val value =  getSharedPreferences(BOX_NAME, Context.MODE_PRIVATE)
      .getString(key, "")
      return value
    }

    private fun setSharedValue(key: String?, value: String?){
            getSharedPreferences(BOX_NAME, Context.MODE_APPEND)
            .edit()
            .putString(key, value)
            .apply()
    }


}
