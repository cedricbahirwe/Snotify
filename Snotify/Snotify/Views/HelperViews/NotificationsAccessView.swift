//
//  NotificationsAccessView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 17/06/2022.
//

import SwiftUI

struct NotificationsAccessView: View {
    var body: some View {
        VStack {
            Text("Ne manque jamais les nouveautés")
                .font(.rounded(.title, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .padding()
            HStack {
                Image(systemName: "info.circle.fill")
                    .imageScale(.large)
                Text("Vous pouvez modifier et désactiver les notifications à tout moment dans vos paramètres.")

            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.accentColor)
            .overlay(Color.accentColor.frame(height: 1), alignment: .top)
            .overlay(Color.accentColor.frame(height: 1), alignment: .bottom)
            .background(Color.accentColor.opacity(0.15))


            VStack {
                Text("Recevez des alerts de nouveaux produits de votre boutique preéferée.")

                HStack(alignment: .top) {
                    Image(systemName: "bell.and.waveform")
                        .imageScale(.large)
                    VStack(alignment: .leading) {
                        Text("Recevez des infos sur les nouveaux produits, événements spéciaux et recommandations personnalisées.")
                    }
                }
            }
            Spacer()
        }
    }
}

struct NotificationsAccessView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsAccessView()
    }
}
