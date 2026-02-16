import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    private let CHANNEL = "vpn_checker"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let vpnChannel = FlutterMethodChannel(name: CHANNEL,
                                               binaryMessenger: controller.binaryMessenger)

        vpnChannel.setMethodCallHandler { (call, result) in
            if call.method == "isVpnActive" {
                result(self.isVpnActive())
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func isVpnActive() -> Bool {
        let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as NSDictionary?
        let scopes = settings?["__SCOPED__"] as? NSDictionary
        for key in scopes?.allKeys ?? [] {
            if let keyStr = key as? String,
               keyStr.starts(with: "utun") || keyStr.starts(with: "ppp") {
                return true
            }
        }
        return false
    }
}
