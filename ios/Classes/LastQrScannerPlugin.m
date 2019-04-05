#import "LastQrScannerPlugin.h"
#import <last_qr_scanner/last_qr_scanner-Swift.h>

@implementation LastQrScannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLastQrScannerPlugin registerWithRegistrar:registrar];
}
@end
