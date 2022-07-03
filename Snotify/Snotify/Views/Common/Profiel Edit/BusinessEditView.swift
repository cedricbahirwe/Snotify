//
//  BusinessEditView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI

extension ProfileEditView {
    struct BusinessEditView: View {
        @Binding var busineessModel: BusinessModel
        var body: some View {
            Group {
                TextField("Business name", text: $busineessModel.name)
                    .textContentType(.organizationName)
                    .font(.rounded())
                    .padding(.horizontal)
                    .frame(height: Layout.fieldHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                TextEditor(text: busineessModel.description.isEmpty ? .constant("Description") : $busineessModel.description)
                    .padding(.horizontal, 10)
                    .frame(maxHeight: 80)
                    .foregroundColor(busineessModel.description.isEmpty ? .secondary : .primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                TextField("Business address", text: $busineessModel.address)
                    .textContentType(.fullStreetAddress)
                    .font(.rounded())
                    .padding(.horizontal)
                    .frame(height: Layout.fieldHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                TextField("email@domain.com", text: $busineessModel.email)
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


                TextField("Numéro de téléphone", text: $busineessModel.phoneNumber)
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
struct BusinessEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView.BusinessEditView(busineessModel: .constant(.init()))
    }
}
