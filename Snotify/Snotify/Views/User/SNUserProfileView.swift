//
//  SNUserProfileView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI

struct SNUserProfileView: ProfileViewProtocol {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Image("iphone4")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .mask(Circle())
                        .clipShape(Circle())
                        .padding(3)
                        .overlay(
                            Circle()
                                .stroke(Color.accentColor, lineWidth: 2)
                        )
                    userDetailsView

                }

                shopContactsView


                ScrollView(.vertical, showsIndicators: false) {
                    followedShopsView
                }
            }
            .padding()

            Spacer()


        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("User Full Name")
        .toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {

                Button {
                    //
                } label: {
                    Label("paramètres", systemImage: "gear")
                }

            }
        }
    }
}

private extension SNUserProfileView {

    private enum Layout {
        static let ctaFrame = CGSize(width: CGFloat.infinity, height: 38)

    }

    var userDetailsView: some View {
        VStack(alignment: .leading) {
            Text("User Full Name")
            Text("@Nickname")
                .font(.callout)
                .foregroundColor(.secondary)

            HStack {
                vStackView("7", "Abonnements")
                    .frame(maxWidth: .infinity)
                vStackView("100", "aimés")
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
    }

    var shopContactsView: some View {
        HStack {
            Button {
                //
            } label: {
                Text("Modifier profil")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 6)
                    .frame(maxWidth: Layout.ctaFrame.width)
                    .frame(height: Layout.ctaFrame.height)
                    .background(Color.clear)
                    .overlay(ctaOverlay)
            }

            Button {
                //
            } label: {
                Text("Contacter")
                    .font(.callout.weight(.semibold))
                    .padding(.horizontal, 6)
                    .frame(maxWidth: Layout.ctaFrame.width)
                    .frame(height: Layout.ctaFrame.height)
                    .background(Color.clear)
                    .overlay(ctaOverlay)
            }
        }
    }

    var followedShopsView: some View {
        VStack {
            ForEach(0 ..< 5) { item in
                HStack {
                    Image("iphone\(item+1)")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .background(.ultraThinMaterial)
                        .mask(Circle())
                        .padding(4)
                        .overlay(
                            Circle().strokeBorder(Color.accentColor, lineWidth: 1.4)
                        )

                    VStack(alignment: .leading) {
                        Text("Business Name")
                            .font(.headline)
                        Text("Business Description")
                            .foregroundColor(.secondary)
                            .font(.callout.weight(.light))
                            .lineLimit(1)
                    }
                }
            }
        }
    }

    private var ctaOverlay: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.secondary, lineWidth: 1)
    }

}

struct SNUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SNUserProfileView()
                .viewInDark()
        }
    }
}
