//
//  PhotosAccessView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 10/06/2022.
//

import SwiftUI

struct PhotosAccessView: View {
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .overlay(
                    Button(action: {
                        isPresented = false
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(.title2,
                                          design: .rounded).weight(.semibold))
                            .padding(10)
                            .foregroundColor(.white)
                    })
                    , alignment: .topLeading
                )
            VStack(spacing: 25) {
                Text("Veuillez autoriser l''accès à vos photos")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))

                Text("Cela autorise Snotify à partager les photos depuis votre bibliothèque et  à enregistrer les photos sur votre pellicule.")
                    .foregroundColor(Color(.lightGray))
                    .multilineTextAlignment(.center)


                Button("Activer l'acces à la bibliothèque") {
                    // Accéder
                    UIApplication.shared.open(URL(string: "app-settings:root=General&path=Snotify")!)

                }
                .font(.system(.callout, design: .rounded).weight(.medium))
                .foregroundColor(.blue)
            }
            .padding()

        }
        
    }
}

#if DEBUG
struct PhotosAccessView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosAccessView(isPresented: .constant(false))
//            .preferredColorScheme(.dark)
    }
}
#endif
