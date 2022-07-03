//
//  ShopPostRowView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 10/06/2022.
//

import SwiftUI

struct ShopPostRowView: View {
    var post: SNShopPost
    init(_ postUpdate: SNShopPost) {
        self.post = postUpdate
    }
    @State private var hasSubscribed = false
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                let image = post.shop.profilePicture ?? "iphone1"
                Image(image)
                    .resizable()
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

                HStack {
                    Button {
                        hasSubscribed.toggle()
                    } label: {
                        Text(hasSubscribed ? "Abonné" : "S'abonner")
                            .font(.system(.callout, design: .rounded))
                            .fontWeight(.medium)
                            .foregroundColor(hasSubscribed ? .white : .green)
                            .padding(.horizontal, 10)
                            .frame(height: 32)
                            .background(hasSubscribed ? .green : .clear, in: RoundedRectangle(cornerRadius: 13))
                            .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.green, lineWidth: 1))
                    }
                    .buttonStyle(.plain)

                    Button(action: showMore) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.primary)
                            .padding(5)
                    }
                }
            }

            VStack(spacing: 0) {
                let image = post.images.isEmpty ? "iphone1" : post.images[0]
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width-10)
                    .overlay(
                        shopContactBanner, alignment: .bottom
                    )
                    .padding(.bottom, 35)
            }
            .clipped()

            VStack(alignment: .leading, spacing: 5) {
                if let description = post.description {
                    Text(description)
                        .font(.system(.body, design: .rounded))
                        .lineLimit(2)
                }

                Text(post.createdDate, format: .relative(presentation: .named))
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.secondary)
            }

        }
        .padding(.bottom)
    }

    private func showMore() {

    }
}

struct ShopPostRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShopPostRowView(.previews[0])
            .padding()
            .previewLayout(.fixed(width: 410, height: 400))
    }
}

private extension ShopPostRowView {
    var shopContactBanner: some View {
        HStack {
            Text("Contact le vendeur")
                .font(.system(.caption, design: .rounded))
                .fontWeight(.medium)
            Spacer()

            Image(systemName: "chevron.right")
        }
        .padding(.horizontal)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 35)
        .background(Color.accentColor)
        .offset(y: 35)
    }
}

