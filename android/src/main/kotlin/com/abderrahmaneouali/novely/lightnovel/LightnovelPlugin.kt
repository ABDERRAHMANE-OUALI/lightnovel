package com.abderrahmaneouali.novely.lightnovel

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/** LightnovelPlugin */
class LightnovelPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "lightnovel")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val scope = CoroutineScope(Dispatchers.IO)
    scope.launch {
      val lightnovel = LightNovel()
      val arguments = (call.arguments as List<String>?)
      when (call.method) {
          "getLightNovelInfo" -> {
            result.success(lightnovel.getLightNovelInfo(arguments?.get(0) ?: ""))
          }
          "getChapterContent" -> {
            result.success(lightnovel.getChapterContent(arguments?.get(0) ?: ""))
          }
          "getPopularLightNovels" -> {
              result.success(lightnovel.getPopularLightNovels())
          }
          else -> {
            result.notImplemented()
          }
      }
    }

  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
