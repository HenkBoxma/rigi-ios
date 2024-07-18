import UIKit

#if RIGI_ENABLED
import Rigi
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        #if RIGI_ENABLED
        RigiSdk.shared.settings.enableAutoScanning = true
        RigiSdk.shared.start()
        #endif

        return true
    }
}

