//
//  SNFirebaseManager.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 26/06/2022.
//

import Firebase

final class SNFirebaseManager {
    static let shared = SNFirebaseManager()
    // MARK: - Initializers
    private init() { }

    func configureApp() {
        FirebaseApp.configure()
    }
}
