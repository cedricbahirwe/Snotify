//
//  SNPublication.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct SNPost: Identifiable, Codable {
    public init(id: String?, images: [String], description: String = "",
                createdDate: Date = Date(), comments: String = "",
                price: Double? = nil, currency: SNCurrency = .usd,
                views: Int = 0, shop: SNPost.SNShop) {
        self.id = id
        self.images = images
        self.description = description
        self.createdDate = createdDate
        self.comments = comments
        self.price = price
        self.currency = currency
        self.views = views
        self.shop = shop
    }
    
    public init(shop: SNPost.SNShop) {
        self.id = nil
        self.images = []
        self.description = ""
        self.createdDate = Date()
        self.comments = ""
        self.price = nil
        self.currency = .usd
        self.views = 0
        self.shop = shop
    }
    
    @DocumentID public var id: String?
    public var images: [String]
    public var description: String
    public var createdDate: Date
    public var comments: String
    public var price: Double?
    public var currency: SNCurrency
    public var views: Int
    public var shop: SNPost.SNShop
}

extension SNPost {

    static let sample = SNSamples.post
    static let samples: [SNPost] = SNSamples.posts
    
    public struct SNShop: Identifiable, Codable {
        public init(id: String, name: String, address: String,
                    profilePicture: String? = nil, location: SNLocation?,
                    description: String? = nil,
                    ownerId: String? = nil) {
            self.id = id
            self.name = name
            self.address = address
            self.profilePicture = profilePicture
            self.location = location
            self.description = description
            self.ownerId = ownerId
        }

        public var id: String
        public var name: String
        public var address: String
        public var profilePicture: String?
        public var location: SNLocation?
        public var description: String?
        public var ownerId: String?

        static let sample = SNSamples.shopPost
        static let samples = SNSamples.shopPosts
    }
}
