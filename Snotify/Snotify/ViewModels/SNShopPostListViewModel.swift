//
//  SNShopPostListViewModel.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 15/07/2022.
//

import Combine

final class SNShopPostListViewModel: ObservableObject {
    @Published private(set) var shopPostVM = [SNShopPostViewModel]()

    private var cancellables = Set<AnyCancellable>()


    init() {

        self.shopPostVM = SNShopPost.previews.map(SNShopPostViewModel.init)

    }


    public func addNewPost(_ post: SNShopPost) {
        let postVM = SNShopPostViewModel(post)
        self.shopPostVM.append(postVM)
    }

    public func insetNewPost(_ post: SNShopPost, at index: Int) {
        let postVM = SNShopPostViewModel(post)
        self.shopPostVM.insert(postVM, at: index)
    }

}
