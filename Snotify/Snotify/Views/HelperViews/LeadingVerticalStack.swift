//
//  LeadingVerticalStack.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 17/06/2022.
//

import SwiftUI

struct LeadingVerticalStack: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hello, World!")

        }
    }
}

struct LeadingVerticalStack_Previews: PreviewProvider {
    static var previews: some View {
        LeadingVerticalStack()
    }
}
