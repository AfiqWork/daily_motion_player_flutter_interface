import 'package:flutter/services.dart';
import 'dart:developer' as developer;


class DailymotionPlayerController {
  final String videoId;
  final String playerId;
  final String channelName; // now pass it in
  late final MethodChannel _methodChannel;

  DailymotionPlayerController({
    required this.videoId,
    required this.playerId,
    required this.channelName, // pass from outside
  }) {
    // Use passed channelName to create MethodChannel
    _methodChannel = MethodChannel(channelName);
  }


  Future<void> play() async {
    try {
      await _methodChannel.invokeMethod('play');
    } on PlatformException catch (e) {
      developer.log("Failed to play video: '${e.message}'.");
    }
  }

  Future<void> pause() async {
    try {
      await _methodChannel.invokeMethod('pause');
    } on PlatformException catch (e) {
      developer.log("Failed to pause video: '${e.message}'.");
    }
  }

  Future<void> load(String videoId) async {
    try {
      await _methodChannel.invokeMethod('load', {'videoId': videoId});
    } on PlatformException catch (e) {
      developer.log("Failed to load video: '${e.message}'.");
    }
  }

  Future<void> seek(double seconds) async {
    try {
      await _methodChannel.invokeMethod('seek', {'seconds': seconds});
    } on PlatformException catch (e) {
      developer.log("Failed to seek video: '${e.message}'.");
    }
  }

  Future<void> replay() async {
    try {
      await _methodChannel.invokeMethod('replay');
    } on PlatformException catch (e) {
      developer.log("Failed to replay video: '${e.message}'.");
    }
  }

  Future<double?> getVideoDuration() async {
    try {
      final duration = await _methodChannel.invokeMethod<double>('getVideoDuration');
      return duration;
    } on PlatformException catch (e) {
      developer.log("Failed to get video duration: '${e.message}'.");
      return null;
    }
  }

  Future<double?> getVideoCurrentTimestamp() async {
    try {
      final timestamp = await _methodChannel.invokeMethod<double>('getVideoCurrentTimestamp');
      return timestamp;
    } on PlatformException catch (e) {
      developer.log("Failed to get video timestamp: '${e.message}'.");
      return null;
    }
  }

  Future<void> setMute() async {
    try {
      await _methodChannel.invokeMethod('setMute');
    } on PlatformException catch (e) {
      developer.log("Failed setMute: '${e.message}'.");
    }
  }

  Future<void> setUnMute() async {
    try {
      await _methodChannel.invokeMethod('setUnMute');
    } on PlatformException catch (e) {
      developer.log("Failed setUnMute: '${e.message}'.");
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    try {
      await _methodChannel.invokeMethod('setPlaybackSpeed', {'speed': speed});
    } on PlatformException catch (e) {
      developer.log("Failed setPlaybackSpeed: '${e.message}'.");
    }
  }
}
