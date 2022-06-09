//
//  SNShopPost.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation

public struct SNShopPost: Identifiable {
    public var id: String
    public var images: [String]
    public var description: String?
    public var createdDate: Date

    public var shop: SNShop
}
