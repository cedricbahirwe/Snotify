//
//  SNShop.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation

public struct SNShop : Identifiable, Codable {
    public var id: String
    public var name: String
    public var address: String
    public var profilePicture: String?
    public var location: SNLocation?
    public var description: String?
    public var metadata: [String: String]
}

public struct SNLocation:  Codable {
    let latitude: Double
    let longitude: Double
}
