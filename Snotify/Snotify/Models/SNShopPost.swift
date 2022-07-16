//
//  SNShopPost.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct SNShopPost: Identifiable, Codable {
    public init(id: String?, images: [String], description: String = "",
                createdDate: Date = Date(), comments: String = "",
                price: Double? = nil, currency: SNCurrency = .usd,
                views: Int = 0, shop: SNShop) {
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
    
    public init(shop: SNShop) {
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
    public var shop: SNShop
}
