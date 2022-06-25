import 'lightnovel_platform_interface.dart';

class Lightnovel {
  Future<Map?> getLightNovelInfo(String name) {
    return LightnovelPlatform.instance.getLightNovelInfo(name);
  }

  Future<String?> getChapterContent(String url) {
    return LightnovelPlatform.instance.getChapterContent(url);
  }

  Future<List?> getPopularLightNovels() {
    return LightnovelPlatform.instance.getPopularLightNovels();
  }
}
