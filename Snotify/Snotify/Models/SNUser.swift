//
//  SNUser.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 20/07/2022.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct SNUser: Identifiable, Codable, FirestoreEntity {
    static var collectionName: SNFBCollectionName { .users }

    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var email: String

    var notificationAuthorized: Bool
    var gender: SNGender
    var notificationToken: String?
    var points: Double
    var isActive: Bool

    var phoneNumber: String?
    var profilePicture: String?
    var messageToken: String?
    var birthdate: Date?
    var joinDate: Date?

    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}


extension SNUser {
    static func getUser(from model: SNLoginView.AuthModel, allowNotification: Bool = true) -> SNUser {
        return SNUser(firstName: model.firstName,
                      lastName: model.lastName,
                      email: model.email,
                      notificationAuthorized: allowNotification,
                      gender: model.gender,
                      points: 100,
                      isActive: true,
                      profilePicture: model.profilePicture,
                      birthdate: model.birthdate,
                      joinDate: Date())
    }
    //    static func buildUser(from data: SNDictionary) -> Self { }
}
