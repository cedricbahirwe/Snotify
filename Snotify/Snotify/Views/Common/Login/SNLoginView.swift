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
    @State private var isRegistration = false
    @State private var authModel = AuthModel()
    @FocusState private var focusedField: AuthModel.Field?
    @State private var showGender = true
    @State private var showProfilePicture = false
    @State private var isUploadingPic = false
    @State private var isDeletingPic = false
    // MARK: - Photo Picker Properties
    @State private var presentPhotoPicker = false
    @State private var selectedImage: UIImage?

    @Namespace var animation
    var body: some View {
        ZStack {
            VStack {
                Text("Snotify")
                    .foregroundColor(.accentColor)
                    .font(.rounded(.largeTitle))
                    .fontWeight(.bold)
                    .padding(.top, isRegistration ? 0 : 30)
                    .ignoresSafeArea(.keyboard, edges: .top)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                isRegistration.toggle()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .font(.body.bold())
                                .padding()
                                .background(.regularMaterial)
                                .mask(Circle())
                        }
                            .disabled(isUploadingPic)
                            .opacity(isRegistration ? 1 : 0)
                        , alignment: .leading
                    )
                    .padding(.bottom)

                GeometryReader { _ in
                    VStack(spacing: 20) {
                        if isRegistration {
                            HStack(spacing: 20) {
                                VStack(alignment: .leading) {
                                    Text("First name")
                                        .font(.rounded(weight: .bold))
                                    TextField("First name", text: $authModel.firstName)
                                        .focused($focusedField, equals: .firstName)
                                        .submitLabel(.next)
                                        .textContentType(.givenName)
                                        .keyboardType(.namePhonePad)
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
                                    TextField("Last name", text: $authModel.lastName)
                                        .focused($focusedField, equals: .lastName)
                                        .submitLabel(.next)
                                        .textContentType(.familyName)
                                        .keyboardType(.namePhonePad)
                                        .font(.rounded())
                                        .padding(.horizontal)
                                        .frame(height: 45)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                }
                            }
                        }

                        VStack(alignment: .leading) {
                            Text("Email")
                                .font(.rounded(weight: .bold))
                            TextField("name@domain.com", text: $authModel.email)
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

                            SecureField("Enter your password", text: $authModel.password)
                                .focused($focusedField, equals: .password)
                                .submitLabel(.join)
                                .textContentType(isRegistration ? .newPassword : .password)
                                .font(.rounded())
                                .padding(.horizontal)
                                .frame(height: 45)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        if isRegistration {
                            VStack(alignment: .leading) {
                                DisclosureGroup("What is your gender?", isExpanded: $showGender) {

                                    HStack(spacing: 2) {
                                        ForEach(SNGender.allCases, id: \.self) { gender in
                                            Button {
                                                withAnimation {
                                                    authModel.gender = gender
                                                }
                                            } label: {
                                                Text(gender.formatted)
                                                    .lineLimit(1)
                                                    .padding(.vertical, 8)
                                                    .padding(.horizontal)
                                                    .frame(maxWidth: gender != .unknown ? nil : .infinity)
                                                    .background(
                                                        ZStack {
                                                            if gender == authModel.gender {
                                                                Color.white
                                                                    .matchedGeometryEffect(id: "on", in: animation)
                                                            } else {
                                                                Color.clear
                                                                    .matchedGeometryEffect(id: "off", in: animation)
                                                            }
                                                        }
                                                    )
                                                    .cornerRadius(12)
                                            }
                                        }
                                    }
                                    .padding(4)
                                    .background(.gray.opacity(0.12))
                                    .cornerRadius(12)
                                    .padding(.vertical, 5)
                                }
                                DatePicker("What is your birthdate?",
                                           selection: $authModel.birthdate,
                                           in: ...Date(),
                                           displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())

                                HStack {
                                    if isUploadingPic {
                                        HStack(spacing: 10) {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                                            Text("Wait a sec, Your picture is being uploaded")
                                                .foregroundColor(.accentColor)
                                                .italic()
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.8)
                                        }
                                        .padding(8)
                                        .frame(maxWidth: .infinity)
                                        .background(.regularMaterial)
                                        .cornerRadius(12)

                                    } else if authModel.profilePicture == nil {
                                        Button {
                                            presentPhotoPicker.toggle()
                                        } label: {
                                            Label {
                                                Text("Add your profile picture")
                                            } icon: {
                                                Image(systemName: "person.circle.fill")
                                                    .imageScale(.large)
                                                    .foregroundStyle(.tint)
                                            }
                                        }
                                        .disabled(isUploadingPic)
                                        
                                    } else {
                                        Label {
                                            Text("Profile Picture Added!")
                                        } icon: {
                                            Image(systemName: "checkmark.seal.fill")
                                                .imageScale(.large)
                                                .foregroundStyle(.tint)
                                        }

                                        Spacer()

                                        Button("View Picture") {
                                            hideKeyboard()
                                            showProfilePicture.toggle()
                                        }

                                    }
                                }
                                .padding(.vertical, 10)
                            }
                        }

                        VStack {
                            Button(action: processManualAuth) {
                                Text(isRegistration ? "Continue" : "Login")
                                    .font(.rounded(weight: .bold))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 45)
                                    .foregroundStyle(.background)
                                    .background(.foreground)
                                    .cornerRadius(15)
                            }
                            .disabled((isRegistration && isUploadingPic))

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

                    }
                    .onSubmit {
                        manageKeyboardFocus()
                    }
                }

                thirdPartiesView
                    .opacity(isRegistration ? 0 : 1)
            }
            .padding(20)
            .background(Color(.systemBackground).ignoresSafeArea().onTapGesture(perform: hideKeyboard))
            .overlay(spinnerView)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onChange(of: selectedImage, perform: { _ in
                uploadProfilePicture()
            })

            if showProfilePicture {
               profilePicPreview
            }
        }
        .fullScreenCover(isPresented: $presentPhotoPicker,
                         onDismiss: uploadProfilePicture) {
            PhotoPickerView(isPresented: $presentPhotoPicker,
                            selectedImage: $selectedImage)
        }
    }

    private func hideKeyboard() {
        focusedField = nil
    }

    private func manageKeyboardFocus() {
        switch focusedField {
        case .firstName:
            focusedField = .lastName
        case .lastName:
            focusedField = .email
        case .email:
            focusedField = .password
        default:
            processManualAuth()
        }
    }

    private func uploadProfilePicture() {
        guard let selectedImage = selectedImage else {
            return
        }
        guard let pngData = selectedImage.pngData() else { return }

        isUploadingPic = true

        SNFirebaseImageUploader.shared.upload(data: pngData,
                                              format:.png,
                                              path: .profiles) { result in
            switch result {
            case .failure(let error):
                printf("Failed to upload", error)
            case .success(let imageURL):
                authModel.profilePicture = imageURL
            }
            isUploadingPic = false
        }
    }

    private func deletePicture() {
        isDeletingPic = true
        SNFirebaseImageUploader.shared.deleteLastUploadedFile { state in
            isDeletingPic = false
            authModel.profilePicture = nil
            selectedImage = nil
            showProfilePicture = false
        }
    }

    private func handleSignup() {
        guard authModel.isReadyForRegistration() else { return }
        printv("Signing Up...")
        focusedField = nil
        isSigningIn = true
        SNFirebaseManager.shared.signUpWithEmailAndPassword(authModel) {
            isSigningIn = false
            if $0 {
                authModel = .init()
                prints("Sucessfully registered and logged in")
            }
        }
    }

    private func handleSignIn() {
        guard authModel.isEmailAndPasswordValid() else { return }
        printv("Signing In...")
        focusedField = nil
        isSigningIn = true
        SNFirebaseManager.shared.signInWithEmailAndPassword(authModel.email,
                                                            authModel.password) {
            isSigningIn = false
            if $0 {
                authModel = .init()
                prints("Sucessfully signed and logged in")
            }
        }
    }

    private func handleGoogleLogin() {
        isSigningIn = true
        SNFirebaseManager.shared.loginWithGoogle { isSigningIn = false }
    }

    private func processManualAuth() {
        if isRegistration {
            handleSignup()
        } else {
            handleSignIn()
        }
    }
}

// MARK: - Views
private extension SNLoginView {
    var profilePicPreview: some View {
        Group {
            Color.black.opacity(0.6).ignoresSafeArea()
                .onTapGesture {
                    guard isDeletingPic == false else { return }
                    showProfilePicture.toggle()
                }
            VStack(spacing: 20) {
                Image(uiImage: selectedImage ?? .init())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .mask(Circle())

                Button(action: deletePicture) {
                    HStack(spacing: 10) {
                        if isDeletingPic {
                            ProgressView()
                        }
                        Text(isDeletingPic ? "Deleting Picture" : "Delete Picture")
                            .font(.callout)
                            .foregroundColor(.red)
                    }
                    .padding(14)
                    .background(.ultraThickMaterial)
                    .cornerRadius(15)
                }
                .disabled(isDeletingPic)
            }
        }
    }
    var spinnerView: some View {
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

    var signUpView: some View {
        Button {
            withAnimation {
                isRegistration.toggle()
            }
        } label: {
            Text(isRegistration ? "Already have an account? Sign In instead." : "Create an account")
                .font(.rounded(.callout, weight: .medium))
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
    }

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

extension SNLoginView {
    struct AuthModel {
        var firstName = ""
        var lastName = ""
        var email: String = ""
        var password: String = ""
        var gender: SNGender = .unknown
        var birthdate: Date = Date()
        var profilePicture: String?

        private var isEmailValid: Bool {
            SNEmailAddress(rawValue: email) != nil
        }
        private var isPasswordValid: Bool {
            password.trimmingCharacters(in: .whitespaces).count >= 6
        }

        private var isFirstNameValid: Bool {
            firstName.trimmingCharacters(in: .whitespaces).count > 1
        }

        private var isLastNameValid: Bool {
            lastName.trimmingCharacters(in: .whitespaces).count > 1
        }

        func isEmailAndPasswordValid() -> Bool {
            isEmailValid && isPasswordValid
        }

        func isReadyForRegistration() -> Bool {
            isEmailValid && isPasswordValid &&
            isFirstNameValid && isLastNameValid
        }

        enum Field: Int {
            case firstName
            case lastName
            case email
            case password
        }
    }
}
