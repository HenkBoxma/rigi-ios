import UIKit
import Rigi

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        #if RIGI_ENABLED
        //RigiSdk.shared.start()
        #endif

        return true
    }
}

