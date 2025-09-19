import 'dart:io';
import 'dart:math';

import 'package:daily_motion_player_flutter_interface/daily_motion_player_flutter_interface.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String id;
  late DailymotionPlayerController controller;

  @override
  void initState() {
    super.initState();
    id = _generateRandomString(4);
    print("code $id");

    controller = DailymotionPlayerController(
      videoId: "x9czhlw",
      playerId: "xqzrc",
      channelName: Platform.isIOS
          ? 'dailymotion-player-channel'
          : 'dailymotion-player-channel-$id',
    );
  }

  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dailymotion Player Example')),
        body: Column(
          children: [
            Center(
              child: RawDailymotionPlayerWidget(
                controller: controller,
                height: 200,
                width: 350,
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton(onPressed: () => controller.play(), child: const Text("Play")),
                    ElevatedButton(onPressed: () => controller.pause(), child: const Text("Pause")),
                    ElevatedButton(onPressed: () => controller.replay(), child: const Text("Replay")),
                    ElevatedButton(onPressed: () => controller.seek(30), child: const Text("Seek 30s")),
                    ElevatedButton(
                        onPressed: () async {
                          final d = await controller.getVideoDuration();
                          print("Duration lol: $d");
                        },
                        child: const Text("Get Duration")),
                    ElevatedButton(
                        onPressed: () async {
                          final t = await controller.getVideoCurrentTimestamp();
                          print("Current Time: $t");
                        },
                        child: const Text("Get Timestamp")),
                    ElevatedButton(
                        onPressed: () async {
                          final b = await controller.playerIsBuffering();
                          print("Is Buffering: $b");
                        },
                        child: const Text("Is Buffering?")),
                    ElevatedButton(
                        onPressed: () async {
                          final p = await controller.playerIsPlaying();
                          print("Is Playing: $p");
                        },
                        child: const Text("Is Playing?")),
                    ElevatedButton(
                        onPressed: () async {
                          final r = await controller.playerIsReplayScreen();
                          print("Is Replay Screen: $r");
                        },
                        child: const Text("Is Replay Screen?")),
                    ElevatedButton(onPressed: () => controller.setMute(), child: const Text("Mute")),
                    ElevatedButton(onPressed: () => controller.setUnMute(), child: const Text("UnMute")),
                    ElevatedButton(
                        onPressed: () => controller.updatePlayerParams(
                          mute: false,
                          volume: 0.5,
                          enableControls: true,
                          scaleMode: "aspectFit",
                        ),
                        child: const Text("Update Params")),
                    ElevatedButton(
                        onPressed: () => controller.setPlaybackSpeed(1.25),
                        child: const Text("Speed 1.25x")),
                    ElevatedButton(onPressed: () => controller.setPlaybackSpeed25(), child: const Text("0.25x")),
                    ElevatedButton(onPressed: () => controller.setPlaybackSpeed50(), child: const Text("0.5x")),
                    ElevatedButton(onPressed: () => controller.setPlaybackSpeed75(), child: const Text("0.75x")),
                    ElevatedButton(onPressed: () => controller.setPlaybackSpeed100(), child: const Text("1.0x")),
                    ElevatedButton(onPressed: () => controller.setPlaybackSpeed125(), child: const Text("1.25x")),
                    ElevatedButton(onPressed: () => controller.setPlaybackSpeed150(), child: const Text("1.5x")),
                    ElevatedButton(onPressed: () => controller.setPlaybackSpeed175(), child: const Text("1.75x")),
                    ElevatedButton(onPressed: () => controller.setPlaybackSpeed200(), child: const Text("2.0x")),
                    ElevatedButton(
                        onPressed: () => controller.load("x7zq9i8"), // another videoId
                        child: const Text("Load Another Video")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
