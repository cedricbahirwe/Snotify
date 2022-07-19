//
//  SNPostRepository.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 15/07/2022.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class SNPostRepository: ObservableObject {
    private let db = Firestore.firestore()

    @Published private(set) var posts = [SNPost]()

    init() {
        loadPosts()
    }

    public func loadPosts() {
        db.collection(.posts).addSnapshotListener { querySnapshot, error in
            if let error = error {
                printf("Firestore error:", error.localizedDescription)
                return
            }
            
            if let querySnapshot = querySnapshot {
                let result = querySnapshot.documents.compactMap { document -> SNPost? in
                    do {
                        let res = try document.data(as: SNPost.self)
                        prints(res)
                        return res
                    } catch {
                        printf("Firestore Decoding error:", error, querySnapshot.documents.forEach { print($0.data()) } )
                        return nil
                    }
                }
                
                self.posts = result
            }
        }
    }

    public func addPost(_ post: SNPost) {
        do {
            let _ = try db.collection(.posts).addDocument(from: post)
        } catch {
            printf("Upload error:", error.localizedDescription)
        }
    }

}
