//
//  SNShopPostViewModel.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 15/07/2022.
//

import Combine

final class SNShopPostViewModel: Identifiable, ObservableObject {
    @Published var post: SNShopPost

    private(set) var id: String = ""

    @Published var hasUserLiked = false

    private var cancellables = Set<AnyCancellable>()

    init(_ post: SNShopPost) {
        self.post = post

        $post
            .map { $0.views == 0 }
            .assign(to: \.hasUserLiked, on: self)
            .store(in: &cancellables)

        $post
            .map { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
