//
//  SnotifyApp.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

@main
struct SnotifyApp: App {
    @UIApplicationDelegateAdaptor var appDelegata: AppDelegate
    var body: some Scene {
        WindowGroup {
            PhotosAccessView(isPresented: .constant(true))
//            TestingView()
//            ContentView()
        }
    }
}
