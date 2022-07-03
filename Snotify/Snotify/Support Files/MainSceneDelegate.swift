//
//  MainSceneDelegate.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 23/06/2022.
//

import SwiftUI

class MainSceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem
    ) async -> Bool {
        // Do something with the shortcut...
        return true
    }
}
