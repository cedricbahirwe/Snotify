//
//  Codable+Extensions.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 14/07/2022.
//

import Foundation

public typealias SNDictionary = [String: Any]

extension Encodable {
    func toDictionary() throws -> SNDictionary {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? SNDictionary else {
            throw SNErrors.genericError
        }
        return dictionary
    }

    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}
