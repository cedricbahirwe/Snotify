//
//  SNShop+Extensions.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation

extension SNShop {
    private static let splashPicture = "https://source.unsplash.com/random"
    static let preview = SNShop(id: UUID().uuidString,
                                name: "Chez Mama Esther",
                                address: "Virunga, Depot No.001",
                                profilePicture: splashPicture,
                                location: SNLocation(latitude: 0.0, longitude: 0.0),
                                description: "Friperies and vente d'habits en gros")

    static let previews: [SNShop] = [
        SNShop(id: UUID().uuidString, name: "MA Eme", address: "Virunga, Depot No.000",
               profilePicture: splashPicture, location: nil, description: "Vente de habits en gros"),
        SNShop(id: UUID().uuidString, name: "Chez Da Eme", address: "Alanine, Depot No.101",
               profilePicture: splashPicture, location: nil, description: "Meilleurs poissons de la ville"),
        SNShop(id: UUID().uuidString, name: "Aristore Devices", address: "Grande barriere, en face de iHUSI hote",
               profilePicture: splashPicture, location: nil, description: "iPhone, Macbook magasing"),
        SNShop(id: UUID().uuidString, name: "Iyange", address: "Goma town, batiment kase, étage 10",
               profilePicture: splashPicture, location: nil, description: "Meilleurs poissons de la ville"),
        SNShop(id: UUID().uuidString, name: "La Beauté", address: "En face de l'hopital General",
               profilePicture: splashPicture, location: nil, description: "Votre supermarché")
    ]
}
