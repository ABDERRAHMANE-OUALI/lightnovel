import 'package:flutter_test/flutter_test.dart';
import 'package:lightnovel/lightnovel.dart';
import 'package:lightnovel/lightnovel_platform_interface.dart';
import 'package:lightnovel/lightnovel_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLightnovelPlatform 
    with MockPlatformInterfaceMixin
    implements LightnovelPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LightnovelPlatform initialPlatform = LightnovelPlatform.instance;

  test('$MethodChannelLightnovel is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLightnovel>());
  });

  test('getPlatformVersion', () async {
    Lightnovel lightnovelPlugin = Lightnovel();
    MockLightnovelPlatform fakePlatform = MockLightnovelPlatform();
    LightnovelPlatform.instance = fakePlatform;
  
    expect(await lightnovelPlugin.getPlatformVersion(), '42');
  });
}
