//
//  SNBusinessProfileView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI
import MapKit

struct SNBusinessProfileView: ProfileViewProtocol {
    var sessionType: SNSessionType = .customer
    @StateObject var shopsListVM = SNShopsListViewModel()
//    @StateObject var userVM = SNpro
    @State private var showSettingsView = false

    private var shopVM: SNShopViewModel {
        shopsListVM.shopsVM.last ?? .init(.preview)
    }
    private var hasLoadShop: Bool { shopsListVM.shopsVM.first != nil }
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Group {
                        if let url = URL(string: shopVM.shop.profilePicture ?? "") {
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
                    .frame(width: 80, height: 80)
                    .mask(Circle())
                    .clipShape(Circle())
                    .padding(3)
                    .overlay(
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 2)
                    )

                    HStack {
                        vStackView("\(shopVM.shop.postsCount)", "Posts")
                            .frame(maxWidth: .infinity)
                        vStackView("\(shopVM.shop.followers)", "Followers")
                            .frame(maxWidth: .infinity)
                        vStackView("\(shopVM.shop.likes)", "Likes")
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

        }
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "Settings",
            isPresented: $showSettingsView
        ) {
            Button {
                // Handle import action.
            } label: {
                Text("Learn More")
            }
            Button("Sign Out", role: .destructive) {
                SNFirebaseManager.shared.signOut()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Text(shopVM.shop.name)
                        .bold()
                }
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    //
                } label: {
                    Label("Edit Profil", systemImage: "pencil")
                }

                Button {
                    showSettingsView.toggle()
                } label: {
                    Label("Settings", systemImage: "gear")
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
            Text(shopVM.shop.name)
            if let categories = shopVM.shop.categories.map(\.rawValue), categories.count > 0 {
                Text(categories.map({ $0.capitalized }).joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Text(shopVM.shop.description ?? "...")
                .font(.callout.weight(.light))

            Text("Address: \(shopVM.shop.address)")
            .font(.callout)
            .foregroundColor(.blue)

        }
    }

    var shopContactsView: some View {
        HStack(spacing: 5) {
            Button {
                //
            } label: {
                Text("Follow")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 6)
                    .frame(maxWidth: Layout.ctaFrame.width)
                    .frame(height: Layout.ctaFrame.height)
                    .background(Color.clear)
                    .overlay(ctaOverlay)
            }

            if shopVM.shop.canCall() {
                Button {
                    shopVM.shop.callShop()
                } label: {
                    Text("Contact")
                        .font(.callout.weight(.semibold))
                        .padding(.horizontal, 6)
                        .frame(maxWidth: Layout.ctaFrame.width)
                        .frame(height: Layout.ctaFrame.height)
                        .background(Color.clear)
                        .overlay(ctaOverlay)
                }
            }

            if shopVM.shop.location != nil {
                Button(action: openMapForPlace) {
                    Text("See on Maps")
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

    func openMapForPlace() {
        guard let location = shopVM.shop.location else { return }
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = shopVM.shop.name
        mapItem.openInMaps(launchOptions: options)
    }
}
struct SNBusinessProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SNBusinessProfileView()
                .viewInDark()
        }
    }
}
