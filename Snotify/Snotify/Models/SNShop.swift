//
//  SNShop.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct SNShop : Identifiable, Codable {
    public init(id: String, name: String, address: String, profilePicture: String? = nil, location: SNLocation? = nil, description: String? = nil) {
        self.id = id
        self.name = name
        self.address = address
        self.profilePicture = profilePicture
        self.location = location
        self.description = description
    }

    @DocumentID public var id: String?
    public var name: String
    public var address: String
    public var profilePicture: String?
    public var location: SNLocation?
    public var description: String?
}

public struct SNLocation: Codable {
    let latitude: Double
    let longitude: Double
}
