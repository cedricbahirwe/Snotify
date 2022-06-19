//
//  Extension+Font.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 17/06/2022.
//

import SwiftUI

extension Font {

    static func rounded(_ style: TextStyle = .body) -> Font {
        .system(style, design: .rounded)
    }

    static func rounded(_ style: TextStyle = .body, weight: Weight = .regular) -> Font {
        .system(style, design: .rounded).weight(weight)
    }

    static func rounded(_ size: CGFloat, _ weight: Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
}
