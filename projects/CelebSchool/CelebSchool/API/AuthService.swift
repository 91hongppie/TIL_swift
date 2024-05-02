//
//  AuthService.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/2/24.
//

import CryptoKit
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore

struct AuthService {
    static let shared = AuthService()
    
    func SignIn(appleIDCredential: ASAuthorizationAppleIDCredential, currentNonce: String, completion: @escaping(() -> Void)) {
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        guard let identityToken = appleIDCredential.identityToken else { return }
        guard let tokenString = String(data: identityToken, encoding: .utf8) else { return }
        let firebaseCredential = OAuthProvider.appleCredential(withIDToken: tokenString, rawNonce: currentNonce, fullName: fullName)
        
        
        Auth.auth().signIn(with: firebaseCredential) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let uid = authResult?.user.uid else { return}
            
            if let email = appleIDCredential.email, let fullName = appleIDCredential.fullName {
                let data = ["email": email, "fullname": fullName, "uid": uid] as [String: Any]
                print("DEBUG: email: \(email), fullname: \(fullName)")
                Firestore.firestore().collection("users").document(uid).setData(data)
            }
            
            let data = ["email": "roxkd12@dreamwiz.com", "fullname": "루피"] as [String: Any]
            Firestore.firestore().collection("users").document(uid).setData(data)
            print("DEBUG: Success Sign in \(authResult?.user)")
            
            completion()
        }
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }

    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
}
