//
//  SNPostingManager.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 25/06/2022.
//

import Foundation

final class SNPostingManager: ObservableObject {
    static var shared = SNPostingManager()
    @Published var isSubmitMode = false
    @Published private(set) var temporaryPost: SNPost?
    @Published private(set) var isPublishingPost: Bool
    @Published private(set) var onPublishPost: ((SNPost?) -> Void)?
    private let localNotification = LocalNotificationManager()
    init() {
        temporaryPost = nil
        isPublishingPost = false
        onPublishPost = nil
    }

    /// Publish a shop post to firebase
    /// - Parameters:
    ///   - post: the shop object to be published
    ///   - completion: return the published post or `nil` if an error happened
    func publishPost(_ post: SNPost, completion: @escaping (SNPost?) -> Void) {
        temporaryPost = post
        isPublishingPost = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            completion(self.temporaryPost)
            self.isPublishingPost = false

            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.temporaryPost = nil
            }
        }
    }


    /// Publish a shop post to firebase
    /// - Parameters:
    ///   - post: the shop object to be published
    ///   - completion: return the published post or `nil` if an error happened
    @MainActor
    func publishPost(_ post: SNPost) async {
        isSubmitMode = false
        temporaryPost = post
        isPublishingPost = true

        let content = SNNotificationMessageData(title: "Publication de \(post.shop.name)!",
                                                body: "Regardez la publication avant qu'elle ne soit partie...")

        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.isPublishingPost = false
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//                self.localNotification.schedulePostNotification(
//                    title: "Publication de \(post.shop.name)!",
//                    subtitle: nil ,
//                    body: "Regardez la publication avant qu'elle ne soit partie..", launchIn: 4,
//                    identifier: UUID().uuidString,
//                    imageName: post.images.first)
                self.temporaryPost = nil
            }
        }
        await FCMNotificationStreamer.sendNotification(type: .topic(.general), content: content)
    }
}
