//
//  AppDelegateFile.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 10/06/2022.
//

import SwiftUI
import CoreLocation

class AppDelegate: NSObject, UIApplicationDelegate {

//    private let locationManager = CLLocationManager()
//    private var ref: Firestore?
//    private let defaults = UserDefaults.standard
//    var friendDelegate: FriendRequestDelegate?
//    var checkInDelegate: CheckInRequestDelegate?
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
//        sceneConfig.delegateClass = SceneDelegate.self
//        return sceneConfig
//    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure FireBase App
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

        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { value, _ in
                print("Notication Authorized: \(value)")
//                UserDefaults.standard.set(value, forKey: HZLocalKeys.isNotificationAuthorized)
            }
        )

        application.registerForRemoteNotifications()

//        Messaging.messaging().delegate = self

        return true
    }

//    func initializeLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.allowsBackgroundLocationUpdates = true
//        locationManager.startUpdatingLocation()
//        locationManager.showsBackgroundLocationIndicator = false
//    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        debugPrint("didReceiveRemoteNotification", userInfo)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        debugPrint("applicationDidEnterBackground")
    }


    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        debugPrint("didRegisterForRemoteNotificationsWithDeviceToken - Message registering \(deviceToken)")
//        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {

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

// MARK: - CLLocationManagerDelegate
extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
//        let currentTime = Date().timeIntervalSince1970
//        let latestUserLocationUpdateTime = defaults.double(forKey: HZLocalKeys.locationTime)
//        hzPrint("OLD: \(oldTime) --- NEW: \(newTime)")

        // Update Firebase UserLocation only if user is not establishment every 8 seconds
//        if (currentTime - latestUserLocationUpdateTime > 8) {
//            guard let currentUserId = defaults.string(forKey: HZLocalKeys.currentUserID),
//                  !defaults.bool(forKey: HZLocalKeys.isEstablishment)else { return }
//            guard let lastLocation = locations.last else { return }
//            updateUserLocation(for: currentUserId, location: lastLocation)
//
//        } else {
//            hzPrint("Update Location1: \(String(describing: locations.first))")
//        }
    }

//    private func updateUserLocation(for currentUserId: String, location: CLLocation) {
//        HoppzAnalytics.shared.updateUserLocation(userID: currentUserId,
//                                                 location: location.coordinate) { success in
//            if success { hzPrint("User location updated success") }
//            else { hzPrint("User location updated failed") }
//        }
//
//        HZFireStoreHelpers.saveUserLocationToCollection(location, userId: currentUserId)
//        defaults.set(Date().timeIntervalSince1970, forKey: HZLocalKeys.locationTime)
//    }
}

// MARK: - MessagingDelegate
//extension AppDelegate: MessagingDelegate {
//
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        hzPrint("Firebase registration token: \(String(describing: fcmToken))")
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

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
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
        print("The notif respo", response.actionIdentifier)
//        handleUserNotifications(response.notification.request.content.userInfo)

//        if let currentUserId = defaults.string(forKey: HZLocalKeys.currentUserID),
//           response.notification.request.content.title != "You've earned points" {
//            let event = EventService.Model(userId: currentUserId,
//                                           eventName: "notifications-interact",
//                                           description: "Interact with Hoppz notifications")
//            EventService.createEvent(event)
//        }

        completionHandler()
    }

//    private func handleUserNotifications(_ userInfo: [AnyHashable: Any]) {
//        hzPrint("Notification Content: \(userInfo)")
//        handleFriendRequestNotification(userInfo)
//        handleCheckInNotification(userInfo)
//    }

//    private func handleFriendRequestNotification(_ userInfo: [AnyHashable: Any]) {
//        let title = userInfo["pushTitle"] as? String ?? "Friends Invitation"
//        guard let initiatorID = userInfo["initiatorId"] as? String,
//        let recipientID = userInfo["recipientId"] as? String
//        else { return  }
//
//        friendDelegate?.didReceiveFriendRequest(title, from: initiatorID, to: recipientID)
//    }

//    private func handleCheckInNotification(_ userInfo: [AnyHashable: Any]) {
//        guard let estsData = userInfo["nearbyEstablishments"] as? String else { return }
//        guard let data = estsData.data(using: .utf8) else { return }
//        let decoder = JSONDecoder()
//        let ests: [NotificationEstInfo] = (try? decoder.decode([NotificationEstInfo].self, from: data)) ?? []
//        checkInDelegate?.didReceiveCheckInRequest(ests)
//    }
}

