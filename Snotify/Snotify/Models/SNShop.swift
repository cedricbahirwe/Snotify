//
//  SNShop.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

public struct SNShop : Identifiable, Codable {
    public init(id: String? = nil, name: String,
                address: String, profilePicture: String? = nil,
                location: SNLocation? = nil, description: String? = nil,
                ownerId: String? = nil, postsCount: Int = 0,
                followers: Int = 0, likes: Int = 0,
                phone: String? = nil,
                categories: [SNShopCategory] = []) {
        self.id = id
        self.name = name
        self.address = address
        self.profilePicture = profilePicture
        self.location = location
        self.description = description
        self.ownerId = ownerId
        self.postsCount = postsCount
        self.followers = followers
        self.likes = likes
        self.categories = categories
        self.phone = phone
    }

    @DocumentID public var id: String?
    public var name: String
    public var address: String
    public var profilePicture: String?
    public var location: SNLocation?
    public var description: String?
    public var ownerId: String?
    public var postsCount: Int
    public var followers: Int
    public var likes: Int
    public var phone: String?
    public var categories: [SNShopCategory]
}

public extension SNShop {
    func canCall() -> Bool {
        guard let phone = phone,
              let url = URL(string: "tel://\(phone)") else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    func callShop() {
        guard canCall() else { return }
        guard let phone = phone,
              let url = URL(string: "tel://\(phone)") else { return }
        UIApplication.shared.open(url)
    }
}
