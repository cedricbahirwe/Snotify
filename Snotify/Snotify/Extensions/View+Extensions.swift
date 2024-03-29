//
//  View+Extensions.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 26/06/2022.
//

import SwiftUI

extension View {
    func getBounds() -> CGRect {
        UIScreen.main.bounds
    }

    func viewInDark() -> some View {
        self.preferredColorScheme(.dark)
    }

    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension NSObject {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root =
                screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}
