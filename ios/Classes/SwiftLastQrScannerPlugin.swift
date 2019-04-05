import Flutter
import UIKit

public class SwiftLastQrScannerPlugin: NSObject, FlutterPlugin {
    @IBOutlet var previewView: UIView!
    
    var factory: QRViewFactory
    
    public init(with registrar: FlutterPluginRegistrar) {
        self.factory = QRViewFactory(withRegistrar: registrar)
        registrar.register(factory, withId: "last_qr_scanner/qrview")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        // let channel = FlutterMethodChannel(name: "last_qr_scanner/qrview", binaryMessenger: registrar.messenger())
        // let instance = SwiftLastQrScannerPlugin()
        // registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(SwiftLastQrScannerPlugin(with: registrar))
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
