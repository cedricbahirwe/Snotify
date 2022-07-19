//
//  SNShopsListViewModel.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 16/07/2022.
//

import Combine

final class SNShopsListViewModel: ObservableObject {
    @Published private var shopRepository = SNShopRepository()
    @Published private(set) var shopsVM = [SNShopViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        shopRepository.$shops
            .map({ $0.map(SNShopViewModel.init) })
            .assign(to: \.shopsVM, on: self)
            .store(in: &cancellables )
    }

    public func addLocalShop(_ shop: SNShop) {
        let shopVM = SNShopViewModel(shop)
        self.shopsVM.append(shopVM)
    }

    public func addRemoteShop(_ shop: SNShop) {
        shopRepository.addShop(shop)
    }
}

