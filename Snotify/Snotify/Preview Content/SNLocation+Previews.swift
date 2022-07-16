//
//  SNLocation+Previews.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 16/07/2022.
//

import Foundation

extension SNLocation {
    private static let randomLatitude = Double.random(in: -90...90)
    private static let randomLongitude = Double.random(in:-180...180)
    static let ramdomLocation: SNLocation = SNLocation(latitude: randomLatitude, longitude: randomLongitude)
}
