#import "LightnovelPlugin.h"
#if __has_include(<lightnovel/lightnovel-Swift.h>)
#import <lightnovel/lightnovel-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lightnovel-Swift.h"
#endif

@implementation LightnovelPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLightnovelPlugin registerWithRegistrar:registrar];
}
@end
