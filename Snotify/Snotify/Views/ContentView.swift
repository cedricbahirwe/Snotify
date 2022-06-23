//
//  ContentView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct ContentView: View {
    enum SFTabs: String {
        case home, profile
    }
    @AppStorage("SelectAppTab")
    private var selectedTab: String = SFTabs.home.rawValue
    @EnvironmentObject
    private var appDelegate: MainAppDelegate
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")

                }
                .tag(SFTabs.home.rawValue)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(SFTabs.profile.rawValue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
