import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let SHARED_CHANNEL = "shared_method_channel" 
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let sharedChannel = FlutterMethodChannel(name: SHARED_CHANNEL, binaryMessenger: controller.binaryMessenger)
    sharedChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
       
      guard let method = call.method as String? else {
        result(FlutterMethodNotImplemented)
        return  
      }
      if method == "getSharedValue"{
        let args = call.arguments as! Dictionary<String, String>
        let key = args["key"]!
        let value  = self.getSharedValue(result: result, key: key)
        result(value)
        return
      }
      if method == "setSharedValue"{
        let args = call.arguments as! Dictionary<String, String>
        let key = args["key"]!
        let value = args["value"]!
        self.setSharedValue(result: result, key: key, value: value)
        result(nil)
        return
      }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  private func setSharedValue(result: FlutterResult, key: String, value:String ) {
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
}

  private func getSharedValue(result: FlutterResult, key: String) -> String? {
   let defaults  = UserDefaults.standard
   if let stringOne = defaults.string(forKey:key) {
      return stringOne
    }
  return nil
}
}

