//
//  SNShopViewModel.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 16/07/2022.
//

import Combine

final class SNShopViewModel: Identifiable, ObservableObject {
    @Published var shop: SNShop

    private(set) var id: String = ""

    @Published var hasUserFollowed = false

    private var cancellables = Set<AnyCancellable>()

    init(_ shop: SNShop) {
        self.shop = shop

        $shop
            .compactMap { $0.id != nil }
            .assign(to: \.hasUserFollowed, on: self)
            .store(in: &cancellables)

        $shop
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}

