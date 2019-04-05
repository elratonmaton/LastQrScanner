//
//  QRView.swift
//  last_qr_scanner
//
//  Created by Josimar Mamani on 4/4/19.
//

import Foundation
import MTBBarcodeScanner

public class QRView:NSObject,FlutterPlatformView {
    @IBOutlet var previewView: UIView!
    var scanner: MTBBarcodeScanner?
    var registrar: FlutterPluginRegistrar
    var channel: FlutterMethodChannel
    
    public init(withFrame frame: CGRect, withRegistrar registrar: FlutterPluginRegistrar, withId id: Int64){
        self.registrar = registrar
        previewView = UIView(frame: frame)
        channel = FlutterMethodChannel(name: "last_qr_scanner/qrview_\(id)", binaryMessenger: registrar.messenger())
    }
    
    func isCameraAvailable(success: Bool) -> Void {
        if success {
            do {
                try scanner?.startScanning(resultBlock: { codes in
                    if let codes = codes {
                        for code in codes {
                            let stringValue = code.stringValue!
                            self.channel.invokeMethod("onRecognizeQR", arguments: stringValue)
                        }
                    }
                })
            } catch {
                NSLog("Unable to start scanning")
            }
        } else {
            UIAlertView(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok").show()
        }
    }
    
    public func view() -> UIView {
        channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch (call.method) {
                case "setDimensions":
                    var arguments = call.arguments as! Dictionary<String, Double>
                    self?.setDimensions(width: arguments["width"] ?? 0,height: arguments["height"] ?? 0)
                case "ToggleTorch":
                    self?.ToggleTorch()
                default: result(FlutterMethodNotImplemented)
            }
            /*guard call.method == "setDimensions" else {
                result(FlutterMethodNotImplemented)
                return
            }
            var arguments = call.arguments as! Dictionary<String, Double>*/
            
        })
        return previewView
    }
    
    func setDimensions(width: Double, height: Double) -> Void {
        previewView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scanner = MTBBarcodeScanner(previewView: previewView)
        MTBBarcodeScanner.requestCameraPermission(success: isCameraAvailable)
    }
    
    func ToggleTorch() -> Void {
        self.scanner?.toggleTorch()
    }
}
