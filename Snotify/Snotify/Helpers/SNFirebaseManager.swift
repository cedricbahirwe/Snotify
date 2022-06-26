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
    @AppStorage("isUserLoggedIn") private var isLoggedIn = false
    static let shared = SNFirebaseManager()
    // MARK: - Initializers
    private override init() {
        super.init()
    }

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
            Auth.auth().signIn(with: credential) { result, error in
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
                print("All email: \(user.email ?? "No email found")")

                print("All metadata: \(String(describing: user.metadata.lastSignInDate))")
                print("All metadata: \(String(describing: user.metadata.creationDate))")


                if let providerData = user.providerData.first {
                    print("User name: \(String(describing: providerData.displayName))")
                    print("User photo: \(String(describing: providerData.photoURL))")
                    print("User email: \(String(describing: providerData.email))")
                    print("User phone: \(String(describing: providerData.phoneNumber))")
                }

                print("User name: \(user.displayName ?? "Hahah!")")
            }
        }
    }


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
