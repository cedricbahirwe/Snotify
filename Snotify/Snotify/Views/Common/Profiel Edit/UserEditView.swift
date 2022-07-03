//
//  UserEditView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI

extension ProfileEditView {
    struct UserEditView: View {
        @Binding var userModel: ProfileEditView.CustomerModel
        var body: some View {
            Group {
                HStack {
                    Group {
                        TextField("Prénom", text: $userModel.firstName)
                            .textContentType(.givenName)

                        TextField("Nom de famille", text: $userModel.lastName)
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
                TextField("nom@domain.com", text: $userModel.email)
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


                TextField("Numéro de téléphone", text: $userModel.phoneNumber)
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
        ProfileEditView.UserEditView(userModel:  .constant(.init()))
    }
}
