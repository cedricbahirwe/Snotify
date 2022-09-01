//
//  FCMNotificationSubscriber.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 01/09/2022.
//

import FirebaseMessaging

public enum FCMNotificationSubscriber {
    static func subscribe(to topic: SNFBNotificationTopic) {
        Messaging
            .messaging()
            .subscribe(toTopic: topic.rawValue,
                       completion: { error in

                if let error = error {
                    print(error)
                    return
                }
            })
    }
}
