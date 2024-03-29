//
//  ShopPostView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 09/06/2022.
//

import SwiftUI

struct ShopPostView: View {
    @Environment(\.dismiss) private var dismiss
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)
    @State private var isHidden = true

    @State private var selectedImage: UIImage?
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image(uiImage: selectedImage ?? SNConstants.placeholderImage)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 150,
                        maxHeight: UIScreen.main.bounds.height/4
                    )
                    .clipped()

                PhotoPickerView(isPresented: .constant(true),
                                selectedImage: $selectedImage)
                .ignoresSafeArea()
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .overlay(
                VStack {
                    Spacer()
                    NavigationLink {
                        NewPostDetailView(image: selectedImage ?? .init())
                    } label: {
                        Text("Continuer")
                            .foregroundColor(.accentColor)
                            .frame(width: 150, height: 40)
                            .background(Color.black.opacity(0.8))
                            .clipShape(Capsule())
                            .foregroundColor(.accentColor)
                    }
                    .disabled(selectedImage==nil)
                }
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label.init("Annuler", systemImage: "xmark")
                            .font(.body.bold())
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Access camera
                    } label: {
                        Label.init("Camera", systemImage: "camera")
                            .font(.body.bold())
                    }
                }
            }
        }
    }

    private func gridImageView(_ imgName: String) -> some View {
        let image = UIImage(named: imgName)
        return Image(imgName)
            .resizable()
            .aspectRatio(1, contentMode: .fill)
            .clipped()
            .id(imgName)
            .overlay(Color.gray.opacity(image==selectedImage ? 0.5 : 0))
            .onTapGesture {
                selectedImage = image
            }
    }
}

struct ShopPostView_Previews: PreviewProvider {
    static var previews: some View {
        ShopPostView()
    }
}




extension ShopPostView {
    var sectionGridView: some View {
        ScrollView(.vertical, showsIndicators: false) {

            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                Section {
                    Image(uiImage: selectedImage ?? SNConstants.placeholderImage)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.width
                        )
                        .background(Color.black)
                }

                Section {
                    LazyVGrid(
                        columns: columns,
                        spacing: 0) {
                            ForEach(0..<18, id:\.self) { i in
                                let imgName = "shoe\(i)"
                                gridImageView(imgName)
                            }

                            ForEach(1..<6, id:\.self) { i in
                                let imgName = "iphone\(i)"
                                gridImageView(imgName)
                            }
                        }
                } header: {
                    Text("Recents")
                        .foregroundColor(.white)
                        .font(.body.weight(.semibold))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.black)
                }

                Section("Recents") {

                }
            }
        }
    }
}
