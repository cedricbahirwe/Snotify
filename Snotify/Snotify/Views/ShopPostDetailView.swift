//
//  ShopPostDetailView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct ShopPostDetailView: View {
    var post: SNShopPost
    @State private var hasSubscribed = false
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image("iphone1")
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
                    Text("Chez Mama Esther")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .minimumScaleFactor(0.9)
                        .lineLimit(1)
                    Text("Virunga, Depot No.01")
                        .font(.caption)
                        .minimumScaleFactor(0.85)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

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
                .redacted(reason: .placeholder)

            }
            .padding()
            Image("iphone2")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 400, maxHeight: 400)
                .cornerRadius(10)

            VStack {
                Text("Nouveau iphone, avec $500, vous l'avez")
                    .lineLimit(2)
            }


            Spacer()
        }
        .padding()
    }
}

struct ShopPostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopPostDetailView(post: .preview)
    }
}
