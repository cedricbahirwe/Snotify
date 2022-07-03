//
//  SNLoginView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 17/06/2022.
//

import SwiftUI

struct SNLoginView: View {
    @State private var isSigningIn = false
    @State private var showRegistrationView = false

    // - MARK: - Private Properties
    @State private var loginModel = LoginModel()

    var body: some View {
        ZStack {
            VStack {
                Text("Snotify")
                    .foregroundColor(.accentColor)
                    .font(.rounded(.largeTitle))
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .ignoresSafeArea(.keyboard, edges: .top)

                GeometryReader { _ in
                    VStack(spacing: 20) {

                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.rounded(weight: .bold))
                            TextField("nom@domain.com", text: $loginModel.email)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
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

                            SecureField("Enter votre mot de passe", text: $loginModel.password)
                                .textContentType(showRegistrationView ? .newPassword : .password)
                                .font(.rounded())
                                .padding(.horizontal)
                                .frame(height: 45)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }

                        VStack {
                            Button(action: processManualAuth) {
                                Text(showRegistrationView ? "S'en enregistrer" : "Se connecter")
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

                        }.hidden()

                        if showRegistrationView {
                            ctaButton
                        }
                    }
                }

                thirdPartiesView
                    .opacity(showRegistrationView ? 0 : 1)
            }
            .padding(20)
            .background(.background, ignoresSafeAreaEdges: .all)
            .overlay(spinnerView)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }

    private var spinnerView: some View {
        ZStack {
            if isSigningIn {
                Color.black
                    .opacity(0.25)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .font(.title2)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }

    private func handleGoogleLogin() {
        isSigningIn = true
        SNFirebaseManager.shared.loginWithGoogle { isSigningIn = false }
    }

    private func processManualAuth() {
        guard loginModel.isValid() else { return }
        isSigningIn = true
        if showRegistrationView {
            SNFirebaseManager.shared.signUpWithEmailAndPassword(loginModel.email,
                                                                loginModel.password) {
                isSigningIn = false
                if $0 {
                    prints("Sucessfully registered and logged in")
                }
            }
        } else {
            SNFirebaseManager.shared.signInWithEmailAndPassword(loginModel.email,
                                                                loginModel.password) {
                isSigningIn = false
                if $0 {
                    prints("Sucessfully signed and logged in")
                }
            }
        }
    }
}

private extension SNLoginView {
    var thirdPartiesView: some View {
        VStack {
            HStack {
                Color.gray.frame(height: 1)
                Text("ou")
                Color.gray.frame(height: 1)
            }
            HStack(spacing: 18) {
                Button(action: handleGoogleLogin) {

                    Label(title:{
                        Text("Google")
                    }) {
                        Image("google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .font(.rounded(weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                }

                Button {
                    // Password
                } label: {
                    Label(title:{
                        Text("Facebook")
                    }) {
                        Image("facebook")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .font(.rounded(weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                }
            }
            ctaButton
        }
    }

    private var ctaButton: some View {
        Button {
            withAnimation {
                showRegistrationView.toggle()
            }
        } label: {
            Text(showRegistrationView ? "Déjà un compte?, connectez-vous plutôt." : "Créer un compte?")
                .font(.rounded(.callout, weight: .medium))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
    }
}

struct SNLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SNLoginView()
//            .viewInDark()
    }
}

private extension SNLoginView {
    struct LoginModel {
        var email: String = ""
        var password: String = ""

        private var isEmailValid: Bool {
            SNEmailAddress(rawValue: email) != nil
        }
        private var isPasswordValid: Bool {
            password.trimmingCharacters(in: .whitespaces).count >= 6
        }

        func isValid() -> Bool {
            isEmailValid && isPasswordValid
        }
    }
}
