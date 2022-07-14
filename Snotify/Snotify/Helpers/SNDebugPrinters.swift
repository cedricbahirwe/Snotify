//
//  SNDebugPrinters.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 26/06/2022.
//

import Foundation

/// Global function to help print  debug only
///
/// - Parameter e: error
func snPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items, separator, terminator)
    #endif
}

/// Global function to help print `failure` on debug scheme only
///
/// - Parameter e: error
func printf(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print("❌", items, separator, terminator)
    #endif
}

/// Global function to help print `success` on debug scheme only
///
/// - Parameter e: error
func prints(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print("✅", items, separator, terminator)
    #endif
}

/// Global function to help print `verbose` on debug scheme only
///
/// - Parameter e: error
func printv(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print("👀", items, separator, terminator)
    #endif
}
