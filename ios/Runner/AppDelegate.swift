import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
import FirebaseAuth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyD5UN2xZnkINI0cKc74RUaq9jUqKthp4eo")
    GeneratedPluginRegistrant.register(with: self)
//    FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
