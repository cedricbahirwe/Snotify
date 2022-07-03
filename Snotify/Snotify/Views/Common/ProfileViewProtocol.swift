//
//  ProfileViewProtocol.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI

public protocol ProfileViewProtocol: View {
    associatedtype VStackView: View
    func vStackView(_ title: LocalizedStringKey,
                    _ subtitle: LocalizedStringKey) -> VStackView
}

extension ProfileViewProtocol {
    func vStackView(_ title: LocalizedStringKey,
                            _ subtitle: LocalizedStringKey) -> some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.caption)

        }
        .lineLimit(1)
        .minimumScaleFactor(0.8)
    }
}
