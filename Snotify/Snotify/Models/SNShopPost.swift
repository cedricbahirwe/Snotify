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
    public init(id: String, images: [String], description: String? = nil, createdDate: Date, comments: String? = nil, price: Double? = nil, currency: String? = nil, views: Int, shop: SNShop) {
        self.id = id
        self.images = images
        self.description = description
        self.createdDate = createdDate
        self.comments = comments
        self.price = price
        self.currency = currency
        self.views = views
        self.shopItem = shop
    }

    @DocumentID public var id: String?
    public var images: [String]
    public var description: String?
    public var createdDate: Date
    public var comments: String?
    public var price: Double?
    public var currency: String?
    public var views: Int
    public var shopItem: SNShop?

    var shop: SNShop { shopItem ?? SNShop.preview }
}
