//
//  SNShopPost+Previews.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 25/06/2022.
//

import Foundation

extension SNShopPost {
    static let preview = SNShopPost(id: UUID().uuidString, images: ["iphone1", "iphone2"],
                                    description: "Nouveau iphone, avec $500, vous l'avez",
                                    createdDate: Date(timeIntervalSinceNow: -600),
                                    shop: .preview)

    static let previews: [SNShopPost] = [
        SNShopPost(id:  UUID().uuidString, images: ["iphone1"],
                   description: "Arrivage des ballons, enfants, trainings", createdDate: Date(timeIntervalSinceNow: 0), shop: .previews[0]),
        SNShopPost(id:  UUID().uuidString, images: ["iphone2"],
                   description: "Frais poissons pour le weekend", createdDate: Date(timeIntervalSinceNow: -100), shop: .previews[1]),
        SNShopPost(id:  UUID().uuidString, images: ["iphone3"],
                   description: "Arrivage des macbooks, M2, prix discutable", createdDate: Date(timeIntervalSinceNow: -340), shop: .previews[2]),
        SNShopPost(id:  UUID().uuidString, images: ["iphone4"],
                   description: "Toutes vos boissons sont prets", createdDate: Date(timeIntervalSinceNow: -500), shop: .previews[3]),
        SNShopPost(id:  UUID().uuidString, images: ["iphone5"],
                   description: "Nouveux produits pour vos courses", createdDate: Date(timeIntervalSinceNow: -1000), shop: .previews[4])
    ]
}
