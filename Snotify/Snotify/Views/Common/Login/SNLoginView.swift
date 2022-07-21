//
//  SNLoginView.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 17/06/2022.
//

import SwiftUI

struct SNLoginView: View {
    // - MARK: - Private Properties
    @State private var isSigningIn = false
    @State private var showRegistrationView = true
    @State private var loginModel = LoginModel()
    @FocusState private var focusedField: LoginModel.Field?
    @State private var showGender = false

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
                        HStack(spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("First name")
                                    .font(.rounded(weight: .bold))
                                TextField("First name", text: $loginModel.email)
                                    .focused($focusedField, equals: .firstName)
                                    .submitLabel(.next)
                                    .textContentType(.givenName)
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
                                Text("Last name")
                                    .font(.rounded(weight: .bold))
                                TextField("Last name", text: $loginModel.email)
                                    .focused($focusedField, equals: .lastName)
                                    .submitLabel(.next)
                                    .textContentType(.familyName)
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
                        }
                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.rounded(weight: .bold))
                            TextField("name@domain.com", text: $loginModel.email)
                                .focused($focusedField, equals: .email)
                                .submitLabel(.next)
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
                            Text("Password")
                                .font(.rounded(weight: .bold))

                            SecureField("Enter your password", text: $loginModel.password)
                                .focused($focusedField, equals: .password)
                                .submitLabel(.join)
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
                            DisclosureGroup("What is your gender?",
                                            isExpanded: $showGender.animation()) {
                                Picker("Select Gender", selection: $loginModel.gender) {
                                    ForEach(SNGender.allCases, id: \.self) { gender in
                                        Text(gender.formatted).tag(gender)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                            }
                            DatePicker("What is your birthdate?",
                                       selection: $loginModel.birthdate,
                                       in: ...Date(),
                                       displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())

                        }
                        .onChange(of: loginModel.gender) { newValue in
                            showGender = false
                        }

                        VStack {
                            Button(action: processManualAuth) {
                                Text(showRegistrationView ? "Continue" : "Login")
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
                            Text("Forgot password?")
                                .font(.rounded(weight: .medium))

                        }.hidden()

                        if showRegistrationView {
                            signUpView
                        }
                    }
                    .onSubmit {
                        manageKeyboardFocus()
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

    private func manageKeyboardFocus() {
        switch focusedField {
        case .email:
            focusedField = .password
        default:
            printv("Signing In")
            processManualAuth()
        }
    }

    private func handleGoogleLogin() {
        isSigningIn = true
        SNFirebaseManager.shared.loginWithGoogle { isSigningIn = false }
    }

    private func processManualAuth() {
        guard loginModel.isValid() else { return }
        focusedField = nil
        isSigningIn = true
        if showRegistrationView {
            SNFirebaseManager.shared.signUpWithEmailAndPassword(loginModel.email,
                                                                loginModel.password) {
                isSigningIn = false
                if $0 {
                    loginModel = .init()
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
                Text("or")
                Color.gray.frame(height: 1)
            }
            HStack(spacing: 18) {
                googleSignInView

//                facebookSignInView
            }
            signUpView
        }
    }

    private var signUpView: some View {
        Button {
            withAnimation {
                showRegistrationView.toggle()
            }
        } label: {
            Text(showRegistrationView ? "Already have an account? Sign In instead." : "Create an account")
                .font(.rounded(.callout, weight: .medium))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
    }
}

private extension SNLoginView {
    var googleSignInView: some View {
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
    }
    var facebookSignInView: some View {
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
        var gender: SNGender = .unknown
        var birthdate: Date = Date()

        private var isEmailValid: Bool {
            SNEmailAddress(rawValue: email) != nil
        }
        private var isPasswordValid: Bool {
            password.trimmingCharacters(in: .whitespaces).count >= 6
        }

        func isValid() -> Bool {
            isEmailValid && isPasswordValid
        }

        enum Field {
            case firstName
            case lastName
            case email
            case password
        }
    }
}
