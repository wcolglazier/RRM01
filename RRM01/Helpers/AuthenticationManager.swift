//
//  AuthenticationManager.swift
//  firebase1
//
//  Created by william colglazier on 04/08/2023.
//

import Foundation
import Firebase



struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init (user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        
    }
    }

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    
    func getAuthenticatedUser () throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    }
    
    // MARK: SIGN IN SSO
    
extension AuthenticationManager {
        
    func signOut() throws {
        try Auth.auth().signOut()
        }
    }

    
// MARK: SIGN IN SSO
    
    extension AuthenticationManager {
        
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}

