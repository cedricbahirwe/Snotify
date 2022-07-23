//
//  SNLocation.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 16/07/2022.
//

import Foundation

public struct SNLocation: Codable {
    let latitude: Double
    let longitude: Double

    private static let randomLatitude = Double.random(in: -90...90)
    private static let randomLongitude = Double.random(in:-180...180)

    static let randomLocation: SNLocation = SNLocation(latitude: randomLatitude, longitude: randomLongitude)
}
