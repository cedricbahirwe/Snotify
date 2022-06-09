//
//  ProfileView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct ProfileView: View {
    private let columns: [GridItem] = Array(repeating: GridItem(), count: 2)

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(.body, design: .rounded).weight(.medium))
                        .padding(8)
                        .onTapGesture {

                        }
                    Image("iphone5")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .padding(2)
                        .background(.background)
                        .clipShape(Circle())
                        .padding(1)
                        .background(.secondary)
                        .clipShape(Circle())
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text("Chez Mama Esther")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.medium)

                        Text("Virunga, Depot No.01")
                            .font(.system(.title3, design: .rounded))
                    }

                    Spacer()

                    Image(systemName: "list.bullet")
                        .font(.system(.body, design: .rounded).weight(.medium))
                        .padding(8)
                        .contextMenu {
                            Button {
                                print("Contact le vendeur")
                            } label: {
                                Label("Contact le vendeur", systemImage: "phone.circle")
                            }

                            Button(role: .destructive)  {
                                print("Enable geolocation")
                            } label: {
                                Label("Signaler un problem", systemImage: "exclamationmark.bubble")
                            }
                        }
                }
                .padding(.horizontal, 10)
            }

            LazyVGrid(columns: columns, spacing: 15) {

                ForEach(0 ..< 5) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Image("iphone\(item+1)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 200)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

                        Text("iPhone Arrivage, moins de $400")
                            .font(.system(.caption, design: .rounded))
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
//            .preferredColorScheme(.dark)
    }
}
