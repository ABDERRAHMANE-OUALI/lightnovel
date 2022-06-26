import Flutter
import UIKit
import Foundation

public class SwiftLightnovelPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "lightnovel", binaryMessenger: registrar.messenger())
    let instance = SwiftLightnovelPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      let lightnovel = LightNovel()
      let arguments = call.arguments as! Array<String>?
      if(call.method == "getLightNovelInfo"){
          result(lightnovel.getLightNovelInfo(name:arguments?[0] ?? ""))
          
      } else if(call.method == "getChapterContent"){
          result(lightnovel.getChapterContent(url: arguments?[0] ?? ""))
      }else if(call.method == "getPopularLightNovels"){
          result(lightnovel.getPopularLightNovel())
      }
    
  }
}
