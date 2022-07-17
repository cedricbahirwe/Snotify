//
//  SNShopPostViewModel.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 15/07/2022.
//

import Combine

final class SNShopPostViewModel: Identifiable, ObservableObject {
    @Published var post: SNPost

    private(set) var id: String = ""

    @Published private(set) var hasUserLiked = false

    private var cancellables = Set<AnyCancellable>()

    init(_ post: SNPost) {
        self.post = post

        $post
            .map { $0.views >= 0 }
            .assign(to: \.hasUserLiked, on: self)
            .store(in: &cancellables)

        $post
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }

    public func subscribe() {
        hasUserLiked.toggle()
    }
}
