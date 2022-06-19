//
//  SNLoginView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 17/06/2022.
//

import SwiftUI

struct SNLoginView: View {
    var body: some View {
        VStack {
            Text("Snotify")
                .foregroundColor(.accentColor)
                .font(.rounded(.largeTitle))
                .fontWeight(.bold)
                .padding(.top, 30)


            VStack(spacing: 20) {

                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.rounded(weight: .bold))
                    TextField("nom@domain.com", text: .constant(""))
                        .font(.rounded())
                        .padding(.horizontal)
                        .frame(height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }

                VStack(alignment: .leading) {
                    Text("Mot de passe")
                        .font(.rounded(weight: .bold))
                    SecureField("Entere votre mot de passe", text: .constant(""))
                        .font(.rounded())
                        .padding(.horizontal)
                        .frame(height: 45)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }

                VStack {
                    Button {
                        // Login
                    } label: {
                        Text("Login")
                            .font(.rounded(weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .foregroundStyle(.background)
                            .background(.foreground)
                            .cornerRadius(15)

                    }

                    Text("Error Message")
                        .font(.rounded(.caption))
                        .foregroundColor(.red)
                        .hidden()
                }
                .padding(.vertical)

                Button {
                    // Password
                } label: {
                    Text("Mot de passe oublié?")
                        .font(.rounded(weight: .medium))
                }
            }
            .frame(maxHeight: .infinity)


            VStack {
                HStack {
                    Color.gray.frame(height: 1)
                    Text("ou")
                    Color.gray.frame(height: 1)
                }
                HStack(spacing: 18) {
                    Button {
                        // Password
                    } label: {
                        Text("Google")
                            .font(.rounded(weight: .bold))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }

                    Button {
                        // Password
                    } label: {
                        Text("Facebook")
                            .font(.rounded(weight: .bold))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                Button {
                    // Password
                } label: {
                    Text("Créer un compte?")
                        .font(.rounded(.callout, weight: .medium))
                }
            .padding(30)
            }
        }
        .padding(20)
    }
}

struct SNLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SNLoginView()
    }
}
