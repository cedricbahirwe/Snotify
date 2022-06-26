//
//  ContentView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject
    private var appDelegate: MainAppDelegate
    @AppStorage("SelectAppTab")
    private var selectedTab: SNTab = SNTab.home

    @AppStorage("SelectAppTab") private var isLoggedIn = false
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")

                    }
                    .tag(SNTab.home)

                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(SNTab.profile)
            }

//            if !isLoggedIn {
            SNLoginView()
                .rotation3DEffect(isLoggedIn ? .degrees(90) : .zero, axis: (x: 0, y: -10, z: 0))
//                .zIndex(isLoggedIn ? -100 : 1)

//            }
        }
        .onAppear() {
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

private extension ContentView {
    enum SNTab: String {
        case home, profile
    }
}
