package com.lol.daily_motion_player_flutter_interface

import android.content.Context
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class DailymotionPlayerNativeView(
    context: Context,
    messenger: BinaryMessenger,
    id: Int,
    creationParams: Map<*, *>?,
    channelName: String
) : PlatformView, MethodChannel.MethodCallHandler {

    private val methodChannel = MethodChannel(messenger, channelName)
    private val controller = DailymotionPlayerController(context, creationParams)

    init {
        methodChannel.setMethodCallHandler(this)
    }

    override fun getView(): View = controller

    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        try {
            when (call.method) {
                "play" -> controller.play().also { result.success(null) }
                "pause" -> controller.pause().also { result.success(null) }
                "load" -> {
                    val videoId = call.argument<String>("videoId")
                    if (videoId != null) controller.loadVideo(videoId)
                    result.success(null)
                }
                "seek" -> {
                    val seconds = (call.argument<Int>("seconds") ?: 0).toLong()
                    controller.seek(seconds)
                    result.success(null)
                }
                "replay" -> controller.replay().also { result.success(null) }
                "getVideoDuration" -> result.success(controller.getVideoDuration())
                "getVideoCurrentTimestamp" -> result.success(controller.getVideoCurrentTimestamp())
                "setPlaybackSpeed" -> {
                    val speed = call.argument<Double>("speed") ?: 1.0
                    controller.setPlaybackSpeed(speed)
                    result.success(null)
                }
                "mute" -> controller.mute().also { result.success(null) }
                "unMute" -> controller.unMute().also { result.success(null) }
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            result.error("NATIVE_ERROR", e.message, null)
        }
    }
}
