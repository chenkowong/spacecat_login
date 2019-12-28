#import "FlutterPluginBatterylevelPlugin.h"
#import <flutter_plugin_batterylevel/flutter_plugin_batterylevel-Swift.h>

@implementation FlutterPluginBatterylevelPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPluginBatterylevelPlugin registerWithRegistrar:registrar];
}
@end
