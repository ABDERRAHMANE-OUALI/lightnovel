import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lightnovel_method_channel.dart';

abstract class LightnovelPlatform extends PlatformInterface {
  /// Constructs a LightnovelPlatform.
  LightnovelPlatform() : super(token: _token);

  static final Object _token = Object();

  static LightnovelPlatform _instance = MethodChannelLightnovel();

  /// The default instance of [LightnovelPlatform] to use.
  ///
  /// Defaults to [MethodChannelLightnovel].
  static LightnovelPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LightnovelPlatform] when
  /// they register themselves.
  static set instance(LightnovelPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map?> getLightNovelInfo(String name) {
    throw UnimplementedError('getLightNovelInfo() has not been implemented.');
  }

  Future<String?> getChapterContent(String url) {
    throw UnimplementedError('getChapterContent() has not been implemented.');
  }

  Future<List?> getPopularLightNovels() {
    throw UnimplementedError(
        'getPopularLightNovels() has not been implemented.');
  }
}
