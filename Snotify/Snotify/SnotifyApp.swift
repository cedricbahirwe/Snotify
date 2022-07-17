//
//  SnotifyApp.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

@main
struct SnotifyApp: App {
    @UIApplicationDelegateAdaptor
    private var appDelegate: MainAppDelegate
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
//            PhotosAccessView(isPresented: .constant(true))
//            TestingView()
            ContentView()
                .onOpenURL(perform: handIncomingURL)

        }
        .onChange(of: scenePhase, perform: observeScenePhase)
    }

    private func observeScenePhase(_ scene: ScenePhase) {
        
        switch scene {
        case .background:
            print("Enter background mode")
        case .inactive:
            print("Enter inactive mode")
        case .active:
            print("Enter active mode")
        @unknown default:
            print("Enter unknown mode")
        }
    }

    private func handIncomingURL(_ url: URL) {
        prints("Well, New URL: \(url)")
    }
}
