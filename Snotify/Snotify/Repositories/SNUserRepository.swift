//
//  SNUserRepository.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 20/07/2022.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class SNUserRepository: ObservableObject {
    private let db = Firestore.firestore()


    func addUser(_ id: String, _ newUser: SNUser) {
        do {
            try db
                .collection(.users)
                .document(id)
                .setData(from: newUser) { error in
                    if let error  = error {
                        print(error.localizedDescription)
                        return
                    }
                }
//            let _ = try db.collection(.users).addDocument(from: post)
        } catch {
            printf("Upload error:", error.localizedDescription)
        }
    }

//    @Published private(set) var shops = [SNShop]()

//    private func loadShops() {
//        db.collection(.shops).addSnapshotListener { querySnapshot, error in
//            if let error = error {
//                printf("Firestore error:", error.localizedDescription)
//                return
//            }
//
//            if let querySnapshot = querySnapshot {
//                let result = querySnapshot.documents.compactMap { document -> SNShop? in
//                    do {
//                        let res = try document.data(as: SNShop.self)
//                        prints(res)
//                        return res
//                    } catch {
//                        printf("Firestore Decoding error:", error, querySnapshot.documents.forEach { print($0.data()) } )
//                        return nil
//                    }
//                }
//
//                self.shops = result
//            }
//        }
//    }

//    public func addShop(_ post: SNShop) {
//        do {
//            let _ = try db.collection(.shops).addDocument(from: post)
//        } catch {
//            printf("Upload error:", error.localizedDescription)
//        }
//    }

}

