import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lightnovel_platform_interface.dart';

/// An implementation of [LightnovelPlatform] that uses method channels.
class MethodChannelLightnovel extends LightnovelPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lightnovel');

  @override
  Future<Map?> getLightNovelInfo(String name) async {
    final version =
        await methodChannel.invokeMethod<Map>('getLightNovelInfo', [name]) ??
            {};
    return version;
  }

  @override
  Future<String?> getChapterContent(String url) async {
    final content =
        await methodChannel.invokeMethod<String>('getChapterContent', [url]) ??
            "";
    return content;
  }

  @override
  Future<List?> getPopularLightNovels() async {
    final content =
        await methodChannel.invokeMethod<List>('getPopularLightNovels') ?? [];
    return content;
  }
}
