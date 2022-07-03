//
//  SNEmailAddress.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 28/06/2022.
//

import Foundation


/// From https://www.swiftbysundell.com/articles/validating-email-addresses/
struct SNEmailAddress: RawRepresentable, Codable {
    let rawValue: String

    init?(rawValue: String) {
        let detector = try? NSDataDetector(
            types: NSTextCheckingResult.CheckingType.link.rawValue
        )

        let range = NSRange(
            rawValue.startIndex..<rawValue.endIndex,
            in: rawValue
        )

        let matches = detector?.matches(
            in: rawValue,
            options: [],
            range: range
        )

        // We only want our string to contain a single email
        // address, so if multiple matches were found, then
        // we fail our validation process and return nil:
        guard let match = matches?.first, matches?.count == 1 else {
            return nil
        }

        // Verify that the found link points to an email address,
        // and that its range covers the whole input string:
        guard match.url?.scheme == "mailto", match.range == range else {
            return nil
        }

        self.rawValue = rawValue
    }
}
