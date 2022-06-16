//
//  TestingView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI
import CoreLocation

struct TestingView: View {
    @ObservedObject var notificationManager = LocalNotificationManager()
    
    @State var showFootnote = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    withAnimation {
                        self.showFootnote.toggle()
                        self.notificationManager.sendNotification(title: "Hurray!", subtitle: nil, body: "If you see this text, launching the local notification worked!", launchIn: 5, identifier: "notificationDemo")
                        
                        self.notificationManager.sendNotification(title: "Hurray!", subtitle: nil, body: "If you see this text, launching the local notification worked!", launchIn: 10, identifier: "cedbahirw")
                    }
                }) {
                    Text("Launch Local Notification 🚀")
                        .font(.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                if showFootnote {
                    Text("Notification Arrives in 5 seconds")
                        .font(.footnote)
                }
            }
            .navigationBarTitle("Local Notification Demo", displayMode: .inline)
        }
    }
    
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}
