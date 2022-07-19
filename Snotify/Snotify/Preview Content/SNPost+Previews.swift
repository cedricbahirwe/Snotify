//
//  SNPost+Previews.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 16/07/2022.
//

import Foundation

extension SNPost {
    private static let splashPicture = "https://source.unsplash.com/random"
    static let preview = SNPost(id: "CC33DDB4-467C-46BF-B0E9-C98492F327B8",
                                    images: [splashPicture, splashPicture],
                                    description: "Nouveau iphone, avec $500, vous l'avez",
                                    createdDate: Date(timeIntervalSinceNow: -600),
                                    shop: .preview)

    static let previews: [SNPost] = [
        SNPost(id: UUID().uuidString,
                   images: [splashPicture],
                   description: "Arrivage des ballons, enfants, trainings",
                   shop: .previews[0]),
        SNPost(id: UUID().uuidString,
                   images: [splashPicture],
                   description: "Frais poissons pour le weekend",
                   createdDate: Date(timeIntervalSinceNow: -100),
                   shop: .previews[1]),
        SNPost(id: UUID().uuidString,
                   images: [splashPicture],
                   description: "Arrivage des macbooks, M2, prix discutable",
                   createdDate: Date(timeIntervalSinceNow: -340),
                   shop: .previews[2]),
        SNPost(id: UUID().uuidString,
                   images: [splashPicture],
                   description: "Toutes vos boissons sont prets",
                   createdDate: Date(timeIntervalSinceNow: -500),
                   shop: .previews[3]),
        SNPost(id: UUID().uuidString,
                   images: [splashPicture],
                   description: "Nouveux produits pour vos courses",
                   createdDate: Date(timeIntervalSinceNow: -1000),
                   shop: .previews[4])
    ]
}
