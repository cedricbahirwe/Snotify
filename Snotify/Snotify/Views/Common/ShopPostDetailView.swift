//
//  ShopPostDetailView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct ShopPostDetailView: View {
    @ObservedObject var postVM: SNShopPostViewModel
    private var post: SNPost { postVM.post }
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Group {
                    if let url = URL(string: post.shop.profilePicture ?? "") {
                        AsyncImage(url: url){ image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                    } else {
                        Color.gray
                    }
                }
                .clipShape(Circle())
                .padding(2)
                .background(.background)
                .clipShape(Circle())
                .padding(1)
                .background(.secondary)
                .clipShape(Circle())
                .frame(width: 40, height: 40)

                VStack(alignment: .leading, spacing: 0) {
                    Text(post.shop.name)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .minimumScaleFactor(0.9)
                        .lineLimit(1)
                    Text(post.shop.address)
                        .font(.caption)
                        .minimumScaleFactor(0.85)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Button {
                    postVM.subscribe()
                } label: {
                    Text(postVM.hasUserFollwed ? "Followed" : "Follow")
                        .font(.system(.callout, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(postVM.hasUserFollwed ? .white : .green)
                        .padding(.horizontal, 10)
                        .frame(height: 32)
                        .background(postVM.hasUserFollwed ? .green : .clear, in: RoundedRectangle(cornerRadius: 13))
                        .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.green, lineWidth: 1))
                }
            }

            Color.gray
                .hidden()
                .overlay(postImageView)
                .frame(maxWidth: 400, maxHeight: 400)
                .cornerRadius(10)


            VStack {
                Text(post.description)
                    .lineLimit(5)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }

    private var postImageView: some View {
        ZStack {
            if let url = URL(string: post.images.isEmpty ? "" : post.images[0]) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
            } else {
                Color.gray
            }
        }
    }
}

struct ShopPostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopPostDetailView(postVM: .init(.preview))
    }
}
