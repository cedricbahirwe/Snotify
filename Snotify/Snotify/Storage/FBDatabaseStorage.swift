//
//  FBDatabaseStorage.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 14/07/2022.
//

import Foundation
import FirebaseDatabase

final class FBDatabaseStorage {
    // Shared instance
    static let shared = FBDatabaseStorage()

    // Store reference to our real time NoSQL DataBase
    private let database = Database.database().reference()

    // MARK: - Private Initializer
    private init() { }

    public func getDatabase() -> DatabaseReference {
        return database
    }

    // MARK: - Create Operations
    public func save<T: Codable>(_ data: T, forKey key: String) {
        database.child(key).setValue(data.toDictionary())
    }

    public func save<T: Codable>(_ value: T, forKey key: String,
                                 completionHandler: @escaping(Error?) -> Void ) {
        database
            .child(key)
            .setValue(value.toDictionary()) { error, _ in
                completionHandler(error)
            }
    }

    // MARK: - Read Operations
    public func getValue<T: Decodable>(forKey key: String, completionHandler: @escaping (T?) -> Void) {
        FBDatabaseStorage.shared.getDatabase()
            .child(key)
            .observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? SNDictionary else {
                    printf("Not a dictionary", snapshot.value ?? "-")
                    return
                }

                do {
                    let result = try SNParser.decode(dictionary, as: T.self)
                    completionHandler(result)
                } catch {
                    printf("Decoding Error: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            }
    }

    // MARK: - Update Operations


    // MARK: - Delete Operations
    public func deleteValue(forKey key: String) {
        database.child(key).setValue(nil)
    }
}
