//
//  BusinessEditView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI

extension ProfileEditView {
    struct BusinessEditView: View {
        typealias Layout = ProfileEditView.Layout
        @Binding var model: BusinessModel
        var body: some View {
            Group {
                TextField("Business name", text: $model.name)
                    .textContentType(.organizationName)
                    .font(.rounded())
                    .padding(.horizontal)
                    .frame(height: Layout.fieldHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                TextEditor(text: model.description.isEmpty ? .constant("Description") : $model.description)
                    .padding(.horizontal, 10)
                    .frame(maxHeight: 80)
                    .foregroundColor(model.description.isEmpty ? .secondary : .primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                TextField("Business address", text: $model.address)
                    .textContentType(.fullStreetAddress)
                    .font(.rounded())
                    .padding(.horizontal)
                    .frame(height: Layout.fieldHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                TextField("email@domain.com", text: $model.email)
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
struct BusinessEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView.BusinessEditView(model: .constant(.init()))
    }
}
