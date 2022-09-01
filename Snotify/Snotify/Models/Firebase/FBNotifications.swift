//
//  FBNotifications.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 31/08/2022.
//

import Foundation

enum SNFBNotificationTopic: String {
    case general
    case announcements
    case stories
}

typealias SNNotificationMessageData = SNNotificationMessage.NotificationData
struct SNNotificationMessage: Codable {
    var notification: NotificationData
    var topic: String?
    var token: String?

    init(_ notificationData: NotificationData, topic: SNFBNotificationTopic, data: [String : String]? = nil) {
        self.notification = notificationData
        self.topic = topic.rawValue
    }

    init(_ notificationData: NotificationData, token: String, data: [String : String]? = nil) {
        self.notification = notificationData
        self.token = token
    }

    struct NotificationData: Codable {
        let title,  body: String

        static func 🆕(_ title: String, _ body: String) -> Self {
            .init(title: title, body: body)
        }
    }
}

protocol SNNotification: Codable {
    var message: SNNotificationMessage { get set }
}

struct SNTopicNotification: SNNotification {
    var message: SNNotificationMessage

    init(_ message: SNNotificationMessage) {
        self.message = message
    }
}

struct SNUserNotification: SNNotification {
    var message: SNNotificationMessage

    init(_ message: SNNotificationMessage) {
        self.message = message
    }
}
