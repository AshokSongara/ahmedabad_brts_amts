import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var methodChannel: FlutterMethodChannel!
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
        methodChannel = FlutterMethodChannel(name: "nativeChannel", binaryMessenger: rootViewController as! FlutterBinaryMessenger)
        
      methodChannel.setMethodCallHandler { (call : FlutterMethodCall, result: @escaping FlutterResult) in
          print("set method call handler")
          if(call.method == "startPayment") {
              var args = call.arguments
              let data:[String:String] = args as![String:String]
              let url = URL(string : data["intentUrl"] ?? "")
              UIApplication.shared.open(url!);
              result("Payment successful")
          }
      }
        
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
