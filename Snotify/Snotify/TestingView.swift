//
//  TestingView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct TestingView: View {
    var post = SNShopPost.preview

    init() {
        FBDatabaseStorage.shared.getDatabase()
            .child(post.id)
            .observeSingleEvent(of: .value) { snapshot in
                guard let postDict = snapshot.value as? SNDictionary else {
                    printv(snapshot.value ?? "-")
                    return
                }

                do {
                    let decodedPost = try SNParser.decode(postDict, as: SNShopPost.self)
                    prints(decodedPost)
                } catch {
                    printf("Decoding Error: \(error.localizedDescription)")
                }
            }
    }
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
        FBDatabaseStorage.shared.getValue(forKey: post.id)
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
            .preferredColorScheme(.light)
    }
}
