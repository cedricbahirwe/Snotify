//
//  SNShopRepository.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 16/07/2022.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class SNShopRepository: ObservableObject {
    private let db = Firestore.firestore()

    @Published private(set) var shops = [SNShop]()

    init() {
        loadShops()
    }

    private func loadShops() {
        db.collection(.shops).addSnapshotListener { querySnapshot, error in
            if let error = error {
                printf("Firestore error:", error.localizedDescription)
                return
            }

            if let querySnapshot = querySnapshot {
                let result = querySnapshot.documents.compactMap { document -> SNShop? in
                    do {
                        let res = try document.data(as: SNShop.self)
                        prints(res)
                        return res
                    } catch {
                        printf("Firestore Decoding error:", error, querySnapshot.documents.forEach { print($0.data()) } )
                        return nil
                    }
                }

                self.shops = result
            }
        }
    }

    public func addShop(_ post: SNShop) {
        do {
            let _ = try db.collection(.shops).addDocument(from: post)
        } catch {
            printf("Upload error:", error.localizedDescription)
        }
    }
}
