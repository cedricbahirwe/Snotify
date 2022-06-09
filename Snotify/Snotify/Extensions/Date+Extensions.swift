//
//  Date+Extensions.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import Foundation

extension Date {
    var timeAgoDisplay: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full

        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
