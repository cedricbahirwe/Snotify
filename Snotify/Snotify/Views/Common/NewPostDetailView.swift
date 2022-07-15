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
    @Environment(\.editMode) private var editMode
    private let currencies = ["USD", "CDF"]
    @State private var selectedCurrency: String = "USD"
    @State private var postDescription = ""
    @EnvironmentObject private var snPostingManager: SNPostingManager
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                    TextField("Enter une description", text: $postDescription)

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
                        TextField("Enter un prix...", text: .constant(""))
                            .keyboardType(.decimalPad)

                        Picker("Choisissez votre devise", selection: $selectedCurrency) {
                            ForEach(currencies, id:\.self) { currency in
                                Text(currency)
                                    .font(.body.weight(.semibold))
                                    .tag(currency)
                                    .id(currency)
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

                    TextField("Laissez un commentaire...", text: .constant(""))
                }

                Divider()

                Toggle("Publier seulement à mes abonnés", isOn: .constant(true))
                    .opacity(0.5)
                    .disabled(true)
                Divider()

            }
            .padding(.horizontal)
        }
        .navigationTitle("Nouveau Post")
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
        let post = SNShopPost(id: UUID().uuidString,
                              images: [imageName],
                              description: postDescription,
                              createdDate: Date(),
                              views: 0,
                              shop: .preview)
        SNPostingManager.shared.publishPost(post)
    }
}

struct NewPostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewPostDetailView(imageName: UIImage.randomIphoneName)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

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
