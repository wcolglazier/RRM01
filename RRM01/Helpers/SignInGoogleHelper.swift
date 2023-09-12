//
//  SignInGoogleHelper.swift
//  firebase1
//
//  Created by william colglazier on 10/08/2023.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let userEmail = gidSignInResult.user.profile?.email, userEmail.hasSuffix("@tamu.edu") else {
            throw NSError(domain: "TAMU_EMAIL_VALIDATION", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Please use a TAMU email to sign in."])
        }

        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString

        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        return tokens
    }
}
