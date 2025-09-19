
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

  @override
  void initState() {
    super.initState();
    id = _generateRandomString(4);
    print("code $id");
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
    final controller = DailymotionPlayerController(
      videoId: "x9czhlw", // put a real videoId
      playerId: "xqzrc",
      channelName: Platform.isIOS ?  'dailymotion-player-channel' : 'dailymotion-player-channel-$id', // your own ID
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dailymotion Player Example')),
        body: Center(
          child: RawDailymotionPlayerWidget(
            controller: controller,
            height: 200,
            width: 350,
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          controller.setMute();
          print("RawDailymotionPlayerWidget ${await controller.playerIsPlaying()}");
        }),
      ),
    );
  }
}


