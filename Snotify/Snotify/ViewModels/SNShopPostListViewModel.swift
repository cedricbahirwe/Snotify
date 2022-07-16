//
//  SNShopPostListViewModel.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 15/07/2022.
//

import Combine

final class SNShopPostListViewModel: ObservableObject {
    @Published private var postRepository = SNPostRepository()
    @Published private(set) var shopPostVM = [SNShopPostViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        postRepository.$posts
            .map({ $0.map(SNShopPostViewModel.init) })
            .assign(to: \.shopPostVM, on: self)
            .store(in: &cancellables )
    }

    public func addLocalPost(_ post: SNPost) {
        let postVM = SNShopPostViewModel(post)
        self.shopPostVM.append(postVM)
    }

    public func addRemotePost(_ post: SNPost) {
        postRepository.addPost(post)
    }

    public func insertNewPost(_ post: SNPost, at index: Int) {
        let postVM = SNShopPostViewModel(post)
        self.shopPostVM.insert(postVM, at: index)
    }
}
