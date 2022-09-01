//
//  SNFirebasehelpers.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 21/07/2022.
//

import FirebaseFirestore

enum HZFireStoreHelpers {
    static func saveFCMRegistrationToken(_ currentUserId: String,_ fcmToken: String?) {
        Firestore.firestore()
            .collection(.users)
            .document(currentUserId)
            .setData(["messageToken": fcmToken as Any],
                     merge: true) { error in
                if let error = error {
                    printf(error.localizedDescription)
                    return
                }
            }
    }
}
