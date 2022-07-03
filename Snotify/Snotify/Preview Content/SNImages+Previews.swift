//
//  SNImages+Previews.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 25/06/2022.
//

import SwiftUI

public extension Image {
    static var randomIphone: Image = Image(uiImage: .randomIphone)
    static var randomIphoneName: String = UIImage.randomIphoneName
}

public extension UIImage {
    static var randomIphone: UIImage = UIImage(named: randomIphoneName)!
    static var randomIphoneName: String = "iphone\(Int.random(in: 1...5))"
}
