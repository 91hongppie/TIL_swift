//
//  LoginController.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/1/24.
//

import UIKit
import CryptoKit
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore

protocol LoginControllerDelegate: class {
    func completedSignIn()
}

class LoginController: UIViewController {
    
    // MARK: - Properties

    private var currentNonce: String?
    weak var delegate: LoginControllerDelegate?
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.addTarget(self, action: #selector(signInWithApple), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true)
    }
    
    @objc func signInWithApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        currentNonce = AuthService.shared.randomNonceString()
        request.nonce = AuthService.shared.sha256(currentNonce!)
               
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: - API
    
    
    // MARK: - Helpers
    
    
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleDismissal))
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension LoginController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            AuthService.shared.SignIn(appleIDCredential: appleIDCredential, currentNonce: currentNonce!) {
                self.delegate?.completedSignIn()
            }
            
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login failed - \(error.localizedDescription)")
    }
}
