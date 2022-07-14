//
//  MainAppDelegate.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 23/06/2022.
//

import Firebase
import CoreLocation
import UIKit
import FirebaseAuth
import GoogleSignIn

final class MainAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    private let locationManager = CLLocationManager()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        // Configure FireBase App
        FirebaseApp.configure()

//        GIDSignIn.sharedInstance.handle(url)
//        GIDSignIn.sharedInstance().delegate = self


//        GIDSign
//        FirebaseApp.configure()
//        // Create the firestore ref
//        ref = Firestore.firestore()
//
//        // Google Messaging Services API Key
//        GMSServices.provideAPIKey(HoppzConstants.googleAPIKey)
//
//        // Location Manager for repetitive location update
//        initializeLocationManager()
//
//        // TODO: What does this do (useful?)
//        defaults.set(false, forKey: HZLocalKeys.signOut)
//
//        // Perform crazt validation and savings
        //        // TODO: Investigate what happens here
        //        AuthenticationService.shared.register()
        //
//        UNUserNotificationCenter.current().delegate = self
//
//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//        UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: { value, _ in
//                print("Notication Authorized: \(value)")
//                //                UserDefaults.standard.set(value, forKey: HZLocalKeys.isNotificationAuthorized)
//            }
//        )
//
//        application.registerForRemoteNotifications()
//
//        Messaging.messaging().delegate = self

        return true
    }


    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NSLog("Remote Notification Registered: ", deviceToken.debugDescription)
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NSLog("Remove Notification Info: ", userInfo)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Notificaiton failure", error.localizedDescription)
    }

    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {

        GIDSignIn.sharedInstance.handle(url)
        // Determine who sent the URL.
        let sendingAppID = options[.sourceApplication]
        debugPrint("source application = \(sendingAppID ?? "Unknown")")

        // Process the URL.
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
              let albumPath = components.path,
              let params = components.queryItems else {
            print("Invalid URL or album path missing")
            return false
        }

        if let photoIndex = params.first(where: { $0.name == "index" })?.value {
            print("albumPath = \(albumPath)")
            print("photoIndex = \(photoIndex)")
            return true
        } else {
            print("Photo index missing")
            return false
        }
    }
}

extension MainAppDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(
            name: nil,
            sessionRole:connectingSceneSession.role)
        if connectingSceneSession.role == .windowApplication {
            configuration.delegateClass = MainSceneDelegate.self
        }
        return configuration
    }
}

// MARK: - Utilities
extension MainAppDelegate {
        func initializeLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
            locationManager.showsBackgroundLocationIndicator = false
        }
}

// MARK: - CLLocationManagerDelegate
extension MainAppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension MainAppDelegate: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let _ = notification.request.content.userInfo

        completionHandler([[.banner, .list, .sound, .badge]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        completionHandler()
    }

}


// MARK: - MessagingDelegate
//extension MainAppDelegate: MessagingDelegate {
//
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        NSLog("Firebase registration token: \(String(describing: fcmToken))")
//
//        let currentUserId = defaults.string(forKey: HZLocalKeys.currentUserID)
//
//        if let currentUserId = currentUserId {
//            HZFireStoreHelpers.saveFCMRegistrationToken(currentUserId, fcmToken)
//        }
//
//        let dataDict: [String: String] = ["token": fcmToken ?? ""]
//        NotificationCenter.default.post(
//            name: Notification.Name("FCMToken"),
//            object: nil,
//            userInfo: dataDict
//        )
//    }
//}
