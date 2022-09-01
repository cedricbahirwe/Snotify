//
//  HomeView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var shopPostListVM = SNShopPostListViewModel()
    @State private var isLoading: Bool = false
    @State private var isAShop: Bool = false
    @StateObject private var snPostingManager = SNPostingManager.shared
    var body: some View {
        NavigationView {
            List {
                if let newPost = snPostingManager.temporaryPost {
                    if snPostingManager.isPublishingPost {
                        HStack {
                            Group {
                                if let url = URL(string: newPost.images.first ?? "") {
                                    AsyncImage(url: url){ image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                } else {
                                    Color.gray
                                }
                            }
                            .frame(width: 40, height: 40)
                            .clipped()
                            Text("Post by \(newPost.shop.name)")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(3)
                        .overlay(Color.accentColor.frame(height: 2), alignment: .bottom)
                        .animation(.easeInOut, value: snPostingManager.isPublishingPost)
                        .onDisappear() {
                            withAnimation {
                                shopPostListVM.addRemotePost(newPost)
                            }
                        }
                    }
                }
                
                ForEach(shopPostListVM.shopPostVM) { postCell  in
                    ZStack(alignment: .leading) {
                        NavigationLink {
                            ShopPostDetailView(postVM: postCell)
                        } label: { EmptyView() }
                            .opacity(0)

                        ShopPostRowView(postCell: postCell)
                    }
                    .listRowBackground(EmptyView())
                    .listRowSeparator(.hidden)
                    .redacted(reason: isLoading ? .placeholder : .init())
                }
            }
            .listStyle(PlainListStyle())
            .fullScreenCover(isPresented: $snPostingManager.isSubmitMode,
                             onDismiss: {
                // On Dismiss, Do Something (e.g: Reload)
            }, content: {
                ShopPostView()
                    .environmentObject(snPostingManager)
            })
            .navigationTitle("News")
            .toolbar {
                ToolbarItem(id: "CreatePost",
                            placement: .navigationBarTrailing,
                            showsByDefault: isAShop) {
                    Button {
                        let data = SNNotificationMessageData(title: "Hello friend", body: "I do not know")
                        let token = "eWrmDi6GfUyDhqLqcSjL_l:APA91bHGlqzX19Nt7ahaVORBZxr_N19sm-crXgMtvNiL2D4_isjQsGKtxUc9QNzU3F2GGxyzDRybPwPX1ib5ts8vWAz1hFj9OOF-F5b-3XVVsUsrS8P8P_IRX_tc79fDCgw3JmZR8hH6"
                        Task {
                            await FCMNotificationStreamer.sendNotification(type:.user(accessToken: token), content: data)
//                            await FCMNotificationStreamer.shared.sendNotification(type: .topic(.stories), content: data)
                        }
//                        snPostingManager.isSubmitMode.toggle()
                    } label: {
                        Label("Publish a new post", systemImage: "plus.square")
                    }
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
