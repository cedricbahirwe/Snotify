//
//  SNSamples.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 23/07/2022.
//

import Foundation

public enum SNSamples {
    static let splashPicture = "https://source.unsplash.com/random"
    
    static let shop = SNShop(
        id: UUID().uuidString,
        name: "Chez Mama Esther",
        address: "Virunga, Depot No.001",
        profilePicture: splashPicture,
        location: SNLocation(latitude: 0.0, longitude: 0.0),
        description: "Friperies and vente d'habits en gros"
    )
    
    static let shops: [SNShop] = [
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
    
    static let post = SNPost(
        id: "CC33DDB4-467C-46BF-B0E9-C98492F327B8",
        images: [splashPicture, splashPicture],
        description: "Nouveau iphone, avec $500, vous l'avez",
        createdDate: Date(timeIntervalSinceNow: -600),
        shop: shopPost
    )
    
    static let posts: [SNPost] = [
        SNPost(id: UUID().uuidString,
               images: [splashPicture],
               description: "Arrivage des ballons, enfants, trainings",
               shop: shopPosts[0]),
        SNPost(id: UUID().uuidString,
               images: [splashPicture],
               description: "Frais poissons pour le weekend",
               createdDate: Date(timeIntervalSinceNow: -100),
               shop: shopPosts[1]),
        SNPost(id: UUID().uuidString,
               images: [splashPicture],
               description: "Arrivage des macbooks, M2, prix discutable",
               createdDate: Date(timeIntervalSinceNow: -340),
               shop: shopPosts[2]),
        SNPost(id: UUID().uuidString,
               images: [splashPicture],
               description: "Toutes vos boissons sont prets",
               createdDate: Date(timeIntervalSinceNow: -500),
               shop: shopPosts[3]),
        SNPost(id: UUID().uuidString,
               images: [splashPicture],
               description: "Nouveux produits pour vos courses",
               createdDate: Date(timeIntervalSinceNow: -1000),
               shop: shopPosts[4])
    ]

    static let shopPost = SNPost.SNShop(
        id: UUID().uuidString,
        name: "Chez Mama Esther",
        address: "Virunga, Depot No.001",
        profilePicture: splashPicture,
        location: SNLocation.randomLocation,
        description: "Friperies and vente d'habits en gros"
    )

    static let shopPosts: [SNPost.SNShop] = [
        .init(id: UUID().uuidString, name: "MA Eme", address: "Virunga, Depot No.000",
              profilePicture: splashPicture, location: nil, description: "Vente de habits en gros"),
        .init(id: UUID().uuidString, name: "Chez Da Eme", address: "Alanine, Depot No.101",
              profilePicture: splashPicture, location: nil, description: "Meilleurs poissons de la ville"),
        .init(id: UUID().uuidString, name: "Aristore Devices", address: "Grande barriere, en face de iHUSI hote",
              profilePicture: splashPicture, location: nil, description: "iPhone, Macbook magasing"),
        .init(id: UUID().uuidString, name: "Iyange", address: "Goma town, batiment kase, étage 10",
              profilePicture: splashPicture, location: nil, description: "Meilleurs poissons de la ville"),
        .init(id: UUID().uuidString, name: "La Beauté", address: "En face de l'hopital General",
              profilePicture: splashPicture, location: nil, description: "Votre supermarché")
    ]
}
