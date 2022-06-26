//
//  TestingView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct TestingView: View {
    let loc = LocalNotificationManager()
    var body: some View {
        VStack {
            
            Button("toggle") {
                loc.schedulePostNotification(title: "asdaf", subtitle: "asfasf", body: "asfasfasf", launchIn: 3, identifier: "asfasfasf")
//                sendNotification
            }
            
            
            Spacer()
        }
    }
    
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
            .preferredColorScheme(.dark)
    }
}
