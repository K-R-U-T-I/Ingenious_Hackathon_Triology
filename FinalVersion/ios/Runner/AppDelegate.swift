import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Add the following line, with your API key
  [GMSServices provideAPIKey: @"AIzaSyAMxVyj8y-9BFHC_ZaKNybVaWaVlVxQYLk"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
