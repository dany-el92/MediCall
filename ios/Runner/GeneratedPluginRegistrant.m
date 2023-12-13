//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_native_splash/FlutterNativeSplashPlugin.h>)
#import <flutter_native_splash/FlutterNativeSplashPlugin.h>
#else
@import flutter_native_splash;
#endif

#if __has_include(<google_mlkit_commons/GoogleMlKitCommonsPlugin.h>)
#import <google_mlkit_commons/GoogleMlKitCommonsPlugin.h>
#else
@import google_mlkit_commons;
#endif

#if __has_include(<google_mlkit_text_recognition/GoogleMlKitTextRecognitionPlugin.h>)
#import <google_mlkit_text_recognition/GoogleMlKitTextRecognitionPlugin.h>
#else
@import google_mlkit_text_recognition;
#endif

#if __has_include(<image_picker_ios/FLTImagePickerPlugin.h>)
#import <image_picker_ios/FLTImagePickerPlugin.h>
#else
@import image_picker_ios;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<url_launcher_ios/URLLauncherPlugin.h>)
#import <url_launcher_ios/URLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterNativeSplashPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterNativeSplashPlugin"]];
  [GoogleMlKitCommonsPlugin registerWithRegistrar:[registry registrarForPlugin:@"GoogleMlKitCommonsPlugin"]];
  [GoogleMlKitTextRecognitionPlugin registerWithRegistrar:[registry registrarForPlugin:@"GoogleMlKitTextRecognitionPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [URLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"URLLauncherPlugin"]];
}

@end
