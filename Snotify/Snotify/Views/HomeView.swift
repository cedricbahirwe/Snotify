//
//  HomeView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var newPosts: [SNShopPost] = SNShopPost.previews
    @State private var isLoading: Bool = false
    @State private var isAShop: Bool = false
    @State private var showNewPostView: Bool = false
    var body: some View {
        NavigationView {
            List(newPosts) { newPost in
                ZStack(alignment: .leading) {
                    NavigationLink {
                        ShopPostDetailView(post: newPost)
                    } label: { EmptyView() }
                        .opacity(0)

                    ShopPostRowView(newPost)
                }
                .listRowBackground(EmptyView())
                .listRowSeparator(.hidden)
                .redacted(reason: isLoading ? .init() : .placeholder)
            }
            .listStyle(PlainListStyle())
            .fullScreenCover(isPresented: $showNewPostView, onDismiss: {
                // On Dismiss, Do Something (e.g: Reload)
            }, content: {
                ShopPostView()
            })
            .navigationTitle("Nouveautés")
            .toolbar {
                ToolbarItem(id: "CreatePost",
                            placement: .navigationBarTrailing,
                            showsByDefault: isAShop) {
                    Button {
                        showNewPostView = true
                        // Create a shop post
                    } label: {
                        Label("Publier a nouveau post",
                              systemImage: "plus.square")
                    }
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    self.isLoading = true
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
