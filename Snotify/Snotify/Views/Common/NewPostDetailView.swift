//
//  NewPostDetailView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 25/06/2022.
//

import SwiftUI

struct NewPostDetailView: View {
    let imageName: String
    @Environment(\.dismiss) private var dismiss
    private let currencies: [SNCurrency] = SNCurrency.allCases
    @EnvironmentObject private var snPostingManager: SNPostingManager
    @State private var postModel = SNPost(shop: .sample)
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                    TextField("Enter une description", text: $postModel.description)
                }

                Divider()

                VStack {
                    HStack {
                        Text("Prix")
                            .font(.body.weight(.medium))
                        Spacer()
                        InfoButton(.price)
                    }

                    HStack {
                        TextField("Entrer le prix...", value:  $postModel.price, format: .number)
                            .keyboardType(.decimalPad)

                        Picker("Choisissez votre devise", selection: $postModel.currency) {
                            ForEach(currencies, id: \.self) { currency in
                                Text(currency.rawValue)
                                    .font(.body.weight(.semibold))
                                    .tag(currency)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .fixedSize()
                    }
                }

                Divider()


                VStack(alignment: .leading) {
                    HStack {
                        Text("Commentaire")
                            .font(.body.weight(.medium))
                        Spacer()
                        InfoButton(.price)
                    }

                    TextField("Laissez un commentaire...", text: $postModel.comments)
                }

                Divider()

            }
            .padding(.horizontal)
        }
        .navigationTitle("New Post")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Retourner", systemImage: "chevron.left")
                        .font(.body.weight(.semibold))
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: publishPost) {
                    Text("Publier")
                        .font(.body.weight(.semibold))
                }
            }
        }
    }

    private func publishPost() {
        self.postModel.images = SNPost.sample.images
        self.postModel.shop.location = SNLocation.randomLocation
        SNPostingManager.shared.publishPost(postModel)
    }
}

#if DEBUG
struct NewPostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewPostDetailView(imageName: UIImage.randomIphoneName)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#endif

struct InfoButton: View {
    init(_ type: InfoButton.InfoType) {
        self.type = type
    }

    private let type: InfoType
    var body: some View {
        Button(action: showInfo) {
            Image(systemName: "info.circle")
        }
    }
    private func showInfo () {}
    enum InfoType {
        case price
    }
}
