//
//  TestingView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct TestingView: View {
    let post = SNShopPost.preview

    var body: some View {
        VStack {

            Text(String(reflecting: post))

            Button("Save", action: saveValue)
                .padding()
            Button("Get", action: getValue)

        }
        .onAppear() {

        }
    }

    private func saveValue() {
        FBDatabaseStorage.shared.save(post, forKey: post.id)
    }

    private func getValue() {
//        FBDatabaseStorage.shared.getValue(forKey: post.id)
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
            .preferredColorScheme(.light)
    }
}
