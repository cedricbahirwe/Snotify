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
import FirebaseFirestore

#warning("After success login check/set the message token for the user and also load their information")
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

    public func getCurrentUserID() -> String? {
        return firebaseAuth.currentUser?.uid
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
                printf("There was signIn error: \(error)")
                return
            }
            
            if let scopes = user?.grantedScopes, !scopes.contains(SignInScope.firebaseMessaging.rawValue) {
                GIDSignIn.sharedInstance.addScopes(
                    [SignInScope.firebaseMessaging.rawValue],
                    presenting: self.getRootViewController())
                { user, error in
                    
                    if let error = error {
                        setSignInFalse()
                        printf("There was scope error: \(error)")
                        return
                    }
                    self.handleSignIn(user, completion: completion)
                }
            } else {
                handleSignIn(user, completion: completion)
            }
        }
    }

    private func handleSignIn(_ user: GIDGoogleUser?, completion: @escaping() -> Void) {

        guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
        else {
            completion()
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: authentication.accessToken)


        // Sign in in FireBase Auth
        self.firebaseAuth.signIn(with: credential) { result, error in
            if let error = error {
                completion()
                printf("There was firebase error: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user else {
                printf("No user found")
                return
            }
            completion()
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
    func signUpWithEmailAndPassword(_ authModel: SNLoginView.AuthModel,
                                    completion: @escaping(Bool) -> Void) {
        firebaseAuth.createUser(withEmail: authModel.email,
                                password: authModel.password)
        { [weak self] result, error in
            guard let self =  self else { return }
            if let error = error {
                completion(false)
                printf("There was an error: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user else {
                completion(false)
                return
            }

            do {
                let isNotificationOn = UserDefaults.standard.bool(forKey: SNKeys.allowNotifications)
                let newUser = SNUser.getUser(from: authModel, allowNotification: isNotificationOn)
                try self.saveUser(user.uid, user: newUser)
                completion(true)
                withAnimation {
                    self.isLoggedIn = true
                }
            } catch {
                printf("Saving error", error.localizedDescription)
                completion(false)
            }
        }
    }

    /// Sign Out of `GoogleSignIn` and `FireBase Auth`
    func signOut() {
        do  {
            GIDSignIn.sharedInstance.signOut()
            try firebaseAuth.signOut()
            withAnimation {
                isLoggedIn = false
            }
        } catch {
            printf("Unable to sign out, error \(error)")
        }
    }
}

// MARK: - SignIn Scopes
extension SNFirebaseManager {
    enum SignInScope: String {
        case firebaseMessaging = "https://www.googleapis.com/auth/firebase.messaging"
    }

}
// MARK: - Store User in DB (Collection)
extension SNFirebaseManager {
    func saveUser(_ id: String, user: SNUser) throws {
        let reference = Firestore.firestore()
        try reference
            .collection(.users)
            .document(id)
            .setData(from: user) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
}

// MARK: - Notification Toke Manager
extension SNFirebaseManager {
    private func handleUserRegistration(for userId: String) {
        let ref = Firestore.firestore()
        ref.collection(.users)
            .document(userId)
            .addSnapshotListener{ (querySnapshot, error) in
                guard let document = querySnapshot?.data() else { return }
                if (document["messageToken"] == nil) {
                    Messaging.messaging().token { token, error in
                        if let error = error {
                            snPrint("Error fetching FCM registration token: \(error)")
                        } else if let token = token {
                            snPrint("FCM registration token: \(token)")
                            ref.collection(.users).document(userId)
                                .setData(["messageToken": token], merge: true) { error in
                                    if  let error = error {
                                        printf(error.localizedDescription)
                                        return
                                    }
                                }
                        }
                    }
                }
            }
    }
}
