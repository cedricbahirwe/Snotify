//
//  SNFirebaseNotificationStreamer.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 31/08/2022.
//

import Firebase
import GoogleSignIn

enum FCMNotificationStreamer  {
    private static let url = URL(string: "https://fcm.googleapis.com/v1/projects/snotify-7ed5e/messages:send")!

    enum SNNotificationType {
        case topic(SNFBNotificationTopic)
        case user(accessToken: String)
    }

    static func sendNotification(type: SNNotificationType, content: SNNotificationMessageData) async {

        let notification: SNUserNotification
        switch type {
        case .topic(let topic):
            notification = SNUserNotification(.init(content, topic: topic))
        case .user(let accessToken):
            notification = SNUserNotification(.init(content, token: accessToken))
        }

        if let user = GIDSignIn.sharedInstance.currentUser {
            let userAccesstoken = user.authentication.accessToken
            await sendNotification(with: userAccesstoken, notification: notification)
        } else if (GIDSignIn.sharedInstance.hasPreviousSignIn()) {
            GIDSignIn.sharedInstance.restorePreviousSignIn()
            guard let userAccesstoken = GIDSignIn.sharedInstance.currentUser?.authentication.accessToken
            else { return }
            await sendNotification(with: userAccesstoken, notification: notification)
        } else {
            print("No User Found")
            return
        }
    }

    private static func sendNotification<T: SNNotification>(with userAccessToken: String, notification: T) async {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(userAccessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encodedData: Data

        do {
            encodedData = try JSONEncoder().encode(notification)
        } catch {
            print(error)
            return
        }

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                print("Notification Response", json)
            }
        } catch {
            print("Checkout failed.", error)
        }
    }
}
