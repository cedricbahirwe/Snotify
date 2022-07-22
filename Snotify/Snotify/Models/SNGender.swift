//
//  SNGender.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 20/07/2022.
//

import Foundation

public enum SNGender: String, Codable, CaseIterable, Equatable {
    case male
    case female
    case unknown

    var formatted: String {
        switch self {
        case .male, .female:
            return rawValue.capitalized
        case .unknown:
            return "I prefer not to say"
        }
    }
}
