//
//  FBDatabaseStorage.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 14/07/2022.
//

import Foundation
import FirebaseDatabase

final class FBDatabaseStorage {
    static let shared = FBDatabaseStorage()
    // MARK: - Private Initializer
    private init() { }
    // Store reference to our real time NoSQL DataBase
    private let database = Database.database().reference()

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
    public func getValue(forKey key: String) -> Decodable? {
//        database.child(key).val
        print(database.value(forKey: key))
        print("Can", database.value(forKey: key) as? Decodable)
        return database.value(forKey: key) as? Decodable
    }


    // MARK: - Update Operations


    // MARK: - Delete Operations
    public func deleteValue(forKey key: String) {
        database.child(key).setValue(nil)
    }
}
