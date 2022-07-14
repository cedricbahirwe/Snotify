//
//  SNParser.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 15/07/2022.
//

import Foundation

enum SNParser {
    static func decode<T: Decodable>(_ value: [String: Any], as type: T.Type) throws -> T {
        do {
            let json = try JSONSerialization.data(withJSONObject: value)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(type, from: json)
            return result
        } catch {
            throw error
        }
    }
}
