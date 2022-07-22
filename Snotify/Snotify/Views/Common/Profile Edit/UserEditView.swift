//
//  UserEditView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI

extension ProfileEditView {
    struct UserEditView: View {
        typealias Layout = ProfileEditView.Layout
        @Binding var model: ProfileEditView.CustomerModel
        var body: some View {
            Group {
                HStack {
                    Group {
                        TextField("Prénom", text: $model.firstName)
                            .textContentType(.givenName)

                        TextField("Nom de famille", text: $model.lastName)
                            .textContentType(.familyName)
                    }
                    .font(.rounded())
                    .padding(.horizontal)
                    .frame(height: Layout.fieldHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                TextField("nom@domain.com", text: $model.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .font(.rounded())
                    .padding(.horizontal)
                    .frame(height: Layout.fieldHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )


                TextField("Numéro de téléphone", text: $model.phoneNumber)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                    .font(.rounded())
                    .padding(.horizontal)
                    .frame(height: Layout.fieldHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
        }
    }
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView.UserEditView(model: .constant(.init()))
    }
}

