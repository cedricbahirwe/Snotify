//
//  SNShop+Extensions.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation

import Foundation

extension SNShop {
    static let preview = SNShop(id: UUID().uuidString,
                                name: "Chez Mama Esther",
                                address: "Virunga, Depot No.001",
                                profilePicture: nil,
                                location: nil,
                                description: "Friperies and vente d'habits en gros")

    static let previews: [SNShop] = [
        SNShop(id: UUID().uuidString, name: "MA Eme", address: "Virunga, Depot No.000",
               profilePicture: nil, location: nil, description: "Vente de habits en gros"),
        SNShop(id: UUID().uuidString, name: "Chez Da Eme", address: "Alanine, Depot No.101",
               profilePicture: nil, location: nil, description: "Meilleurs poissons de la ville"),
        SNShop(id: UUID().uuidString, name: "Aristore Devices", address: "Grande barriere, en face de iHUSI hote",
               profilePicture: nil, location: nil, description: "iPhone, Macbook magasing"),
        SNShop(id: UUID().uuidString, name: "Iyange", address: "Goma town, batiment kase, étage 10",
               profilePicture: nil, location: nil, description: "Meilleurs poissons de la ville"),
        SNShop(id: UUID().uuidString, name: "La Beauté", address: "En face de l'hopital General",
               profilePicture: nil, location: nil, description: "Votre supermarché")
    ]
}
