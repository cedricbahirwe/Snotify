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

    @Published private(set) var hasUserFollwed = false

    private var cancellables = Set<AnyCancellable>()

    private let userShops = [String]()
    init(_ post: SNPost) {
        self.post = post

        $post
            .map { self.userShops.contains($0.shop.id) }
            .assign(to: \.hasUserFollwed, on: self)
            .store(in: &cancellables)

        $post
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }

    public func subscribe() {
        hasUserFollwed.toggle()
    }
}
