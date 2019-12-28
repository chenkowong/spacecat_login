#import "SpacecatLoginPlugin.h"
#import <spacecat_login/spacecat_login-Swift.h>

@implementation SpacecatLoginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSpacecatLoginPlugin registerWithRegistrar:registrar];
}
@end
