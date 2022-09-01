//
//  MainAppDelegate.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 23/06/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

final class MainAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    private let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        FirebaseApp.configure()

        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { value, _ in
                print("Notication Authorized: \(value)")
                UserDefaults.standard.set(value, forKey: SNKeys.allowNotifications)
            }
        )

        application.registerForRemoteNotifications()

        return true
    }


    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NSLog("Remote Notification Registered: ", deviceToken.debugDescription)
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            prints("Message ID", messageID)
        }

        prints(userInfo)

        completionHandler(.newData)
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

// MARK: - MessagingDelegate
extension MainAppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        NSLog("Firebase registration token: \(String(describing: fcmToken))")

        if let userID = SNFirebaseManager.shared.getCurrentUserID() {
            print("Saving the token...")
            HZFireStoreHelpers.saveFCMRegistrationToken(userID, fcmToken)
            FCMNotificationSubscriber.subscribe(to: .stories)
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate
@available(iOS 10, *)
extension MainAppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
      let userInfo = notification.request.content.userInfo

      if let messageID = userInfo[gcmMessageIDKey] {
          prints("Message ID", messageID)
      }
      print(userInfo)

      // Change this to your preferred presentation option
      completionHandler([[.banner, .list, .badge, .sound]])
  }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            prints("Message ID", messageID)
        }
        print(userInfo)


        completionHandler()
    }
}

//final class Something: Messerv
