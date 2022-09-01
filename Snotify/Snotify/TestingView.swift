//
//  TestingView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct TestingView: View {

    var body: some View {
        VStack {
        }
        .onAppear(perform: test)
    }

    private func test() {
        
    }

}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
            .preferredColorScheme(.light)
    }
}
