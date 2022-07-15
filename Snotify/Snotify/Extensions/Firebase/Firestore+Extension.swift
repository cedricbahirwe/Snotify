//
//  Firestore+Extension.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 15/07/2022.
//

import FirebaseFirestore

extension Firestore {
    func collection(_ name: SNFBCollectionName) -> CollectionReference {
        collection(name.rawValue)
    }
}

extension DocumentReference {
    func collection(_ name: SNFBCollectionName) -> CollectionReference {
        collection(name.rawValue)
    }
}

