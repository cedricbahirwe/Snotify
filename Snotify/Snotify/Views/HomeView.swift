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
    @StateObject private var snPostingManager = SNPostingManager.shared
    var body: some View {
        NavigationView {
            List {
                if let newPost = snPostingManager.temporaryPost {
                    if snPostingManager.isPublishingPost {
                        HStack {
                            Image(newPost.images.first ?? "")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Publier par \(newPost.shop.name)")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(3)
                        .overlay(Color.accentColor.frame(height: 2), alignment: .bottom)
                        .animation(.easeInOut, value: snPostingManager.isPublishingPost)
                        .onDisappear() {
                            withAnimation {
                                newPosts.insert(newPost, at: 0)
                            }
                        }
                    }
                }
                
                ForEach(newPosts) { post in
                    ZStack(alignment: .leading) {
                        NavigationLink {
                            ShopPostDetailView(post: post)
                        } label: { EmptyView() }
                            .opacity(0)

                        ShopPostRowView(post)
                    }
                    .listRowBackground(EmptyView())
                    .listRowSeparator(.hidden)
                    .redacted(reason: isLoading ? .init() : .placeholder)
                }
            }
            .listStyle(PlainListStyle())
            .fullScreenCover(isPresented: $snPostingManager.isSubmitMode, onDismiss: {
                // On Dismiss, Do Something (e.g: Reload)
            }, content: {
                ShopPostView()
                    .environmentObject(snPostingManager)
            })
            .navigationTitle("Nouveautés")
            .toolbar {
                ToolbarItem(id: "CreatePost",
                            placement: .navigationBarTrailing,
                            showsByDefault: isAShop) {
                    Button {
                        snPostingManager.isSubmitMode.toggle()
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
