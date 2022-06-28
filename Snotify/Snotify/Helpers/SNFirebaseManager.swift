//
//  SNFirebaseManager.swift
//  Snotify
//
//  Created by Cédric Bahirwe on 26/06/2022.
//

import Firebase
import GoogleSignIn
import Foundation
import SwiftUI

final class SNFirebaseManager: NSObject {
    @AppStorage(SNKeys.isUserLoggedIn)
    private var isLoggedIn = false
    static let shared = SNFirebaseManager()
    private let firebaseAuth = Auth.auth()

    // Check whether there's a SDK loggedIn user
    var hasFirebaseCurrentUser: Bool {
        firebaseAuth.currentUser != nil
    }

    // MARK: - Initializers
    private override init() {
        super.init()
    }

    /// Sig In usin `GoogleSinIn` and on success sign In in `Firebase`
    /// - Parameter completion: <#completion description#>
    func loginWithGoogle(completion: @escaping() -> Void) {
        func setSignInFalse() {
            completion()
        }
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            setSignInFalse()
            return
        }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)


        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(
            with: config,
            presenting: getRootViewController())
        { [self] user, error in
            if let error = error {
                setSignInFalse()
                printf("There was an error: \(error)")
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                setSignInFalse()
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)


            // Sign in in FireBase Auth
            self.firebaseAuth.signIn(with: credential) { result, error in
                if let error = error {
                    setSignInFalse()
                    printf("There was an error: \(error.localizedDescription)")
                    return
                }

                guard let user = result?.user else {
                    printf("No user found")
                    return
                }
                setSignInFalse()
                withAnimation {
                    self.isLoggedIn = true
                }

                print("User ID: \(String(describing: user.uid))")

                print("User name: \(String(describing: user.displayName))")

                print("User Photo URL: \(String(describing: user.photoURL))")

                print("User email: \(user.email ?? "No email found")")

                print("User phone: \(user.phoneNumber ?? "No phone found")")
            }
        }
    }

    /// Sign In existing user using Firebase
    /// - Parameters:
    ///   - email: user's email
    ///   - password: user's password
    ///   - completion: whether the Sign In process was successful
    func signInWithEmailAndPassword(_ email: String, _ password: String, completion: @escaping(Bool) -> Void) {
        firebaseAuth.signIn(
            withEmail: email,
            password: password) { [weak self] result, error in
                guard let self =  self else { return }
                if let error = error {
                    completion(false)
                    printf("There was an error: \(error)")
                    return
                }

                guard let result = result else {
                    completion(false)
                    return
                }
                completion(true)
                prints("\(String(describing: result.user.email))")
                prints("\(String(describing: result.user.displayName))")
                withAnimation {
                    self.isLoggedIn = true
                }

            }
    }

    /// Sign up new user using Firebase
    /// - Parameters:
    ///   - email: user's email
    ///   - password: user's password
    ///   - completion: whether the Sign Up process was successful
    func signUpWithEmailAndPassword(_ email: String,
                                    _ password: String,
                                    completion: @escaping(Bool) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self =  self else { return }
            if let error = error {
                completion(false)
                printf("There was an error: \(error.localizedDescription)")
                return
            }

            guard let result = result else {
                completion(false)
                return
            }
            completion(true)
            prints("\(result.user)")
            prints("\(String(describing: result.user.email))")
            prints("\(String(describing: result.user.displayName))")
            withAnimation {
                self.isLoggedIn = true
            }
        }
    }

    /// Sign Out of `GoogleSignIn` and `FireBase Auth`
    func signOut() {
        do  {
            GIDSignIn.sharedInstance.signOut()
            try Auth.auth().signOut()
            withAnimation {
                isLoggedIn = false
            }
        } catch {
            printf("Unable to sign out, error \(error)")
        }
    }
}
