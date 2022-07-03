//
//  SNBusinessProfileView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI


struct SNBusinessProfileView: ProfileViewProtocol {
    var sessionType: SNSessionType = .customer

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Image("iphone1")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .mask(Circle())
                        .clipShape(Circle())
                        .padding(3)
                        .overlay(
                            Circle()
                                .stroke(Color.accentColor, lineWidth: 2)
                        )


                    HStack {
                        vStackView("7", "Publications")
                            .frame(maxWidth: .infinity)
                        vStackView("100", "Abonnés")
                            .frame(maxWidth: .infinity)
                        vStackView("1233", "J'aime")
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                }

                shopDetailsView

                shopContactsView


                ScrollView(.vertical, showsIndicators: false) {
                    shopPostsView
                }
            }
            .padding()

            Spacer()


        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Text("Business Name")
                        .bold()
                }
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    //
                } label: {
                    Label("Modifier le profile", systemImage: "pencil")
                }

                Button {
                    //
                } label: {
                    Label("paramètres", systemImage: "gear")
                }

            }
        }
    }
}

private extension SNBusinessProfileView {

    private enum Layout {
        static let ctaFrame = CGSize(width: CGFloat.infinity, height: 38)

        static var postsColumns: [GridItem] = Array(repeating: GridItem(spacing: 1), count: 3)

    }

    var shopDetailsView: some View {
        VStack(alignment: .leading) {
            Text("Business Name")
            Text("Catégorie(s)")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("Business Description is where the business can describe what they do or what theoffer.")
                .font(.callout.weight(.light))


            Group {
                Text("Business Address If Any.")
                Text("Business Website Link If Any.")
            }
            .font(.callout)
            .foregroundColor(.blue)

        }
    }

    var shopContactsView: some View {
        HStack(spacing: 5) {
            Button {
                //
            } label: {
                Text("S'abonner")
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


            Button {
                //
            } label: {
                Text("Voir sur Maps")
                    .font(.callout.weight(.semibold))
                    .padding(.horizontal, 8)
                    .frame(maxWidth: Layout.ctaFrame.width)
                    .frame(height: Layout.ctaFrame.height)
                    .background(Color.clear)
                    .overlay(ctaOverlay)
            }
            .fixedSize()
        }
    }

    var shopPostsView: some View {
        GeometryReader { _ in
            LazyVGrid(columns: Layout.postsColumns, spacing: 1) {

                ForEach(0 ..< 5) { item in
                    Image("iphone\(item+1)")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .background(.ultraThinMaterial)
                }
            }
        }
    }

    private var ctaOverlay: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color.secondary, lineWidth: 1)
    }

}
struct SNBusinessProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SNBusinessProfileView()
//                .viewInDark()
        }
    }
}
