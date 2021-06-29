import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("AIzaSyAixWpeG2pCQGvAQ-KYHG7CNzEq0v4L7iY")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
