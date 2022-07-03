//
//  ProfileEditView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 03/07/2022.
//

import SwiftUI

struct ProfileEditView: View {
    var sessionType: SNSessionType = .business
    // MARK: Customer Properties
    @State private var userModel = CustomerModel()

    // MARK: Business Properties
    @State private var businessModel = BusinessModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Vous y etes presque, Please fill in the missing information")
                .font(.rounded(.title).weight(.bold))
                .padding(.top, 50)
            VStack(alignment: .leading, spacing: 20) {
                switch sessionType {
                case .customer:
                    UserEditView(model: $userModel)
                case .business:
                    BusinessEditView(model: $businessModel)
                }

                Button(action: submitDetails) {
                    Text("Confirmer")
                        .font(.rounded(weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .foregroundStyle(.background)
                        .background(.foreground)
                        .cornerRadius(15)
                }
                .padding(.vertical)
            }
            .frame(maxHeight: .infinity, alignment: .top)

        }
        .padding(.horizontal)
    }

    private func submitDetails() {

    }


    enum Layout {
        static let fieldHeight: CGFloat = 40
    }
}

extension ProfileEditView {
    
    struct CustomerModel {
        var firstName = ""
        var lastName = ""
        var email = ""
        var phoneNumber = ""
    }

    struct BusinessModel {
        var name = ""
        var address = ""
        var coordinates: (lat: Double, lon: Double) = (0,0)
        var email = ""
        var description = ""
        var phoneNumber = ""
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
