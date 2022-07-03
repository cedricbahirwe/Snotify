//
//  LeadingVerticalStack.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 17/06/2022.
//

import SwiftUI

typealias LeadingVerticalStack = LVStack
struct LVStack<Content: View>: View {
    private var spacing: CGFloat?
    private var contentView: Content
    init(spacing: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.contentView = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            contentView
        }
    }
}

struct LeadingVerticalStack_Previews: PreviewProvider {
    static var previews: some View {
        LeadingVerticalStack {
//            Text("Information")
            Text("Informatioan")
            Text("Information")
            Text("Information")
            Text("Information")
            Text("Information")
            Text("Information")
            Text("Information")
            Text("Information")
            Text("Information")
            Text("Information")
        }
    }
}
