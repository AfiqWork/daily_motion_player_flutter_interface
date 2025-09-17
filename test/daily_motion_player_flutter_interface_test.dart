import 'package:flutter_test/flutter_test.dart';
import 'package:daily_motion_player_flutter_interface/daily_motion_player_flutter_interface.dart';
import 'package:daily_motion_player_flutter_interface/daily_motion_player_flutter_interface_platform_interface.dart';
import 'package:daily_motion_player_flutter_interface/daily_motion_player_flutter_interface_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDailyMotionPlayerFlutterInterfacePlatform
    with MockPlatformInterfaceMixin
    implements DailyMotionPlayerFlutterInterfacePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DailyMotionPlayerFlutterInterfacePlatform initialPlatform = DailyMotionPlayerFlutterInterfacePlatform.instance;

  test('$MethodChannelDailyMotionPlayerFlutterInterface is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDailyMotionPlayerFlutterInterface>());
  });

  test('getPlatformVersion', () async {
    DailyMotionPlayerFlutterInterface dailyMotionPlayerFlutterInterfacePlugin = DailyMotionPlayerFlutterInterface();
    MockDailyMotionPlayerFlutterInterfacePlatform fakePlatform = MockDailyMotionPlayerFlutterInterfacePlatform();
    DailyMotionPlayerFlutterInterfacePlatform.instance = fakePlatform;

    expect(await dailyMotionPlayerFlutterInterfacePlugin.getPlatformVersion(), '42');
  });
}
