//
//  LoginController.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/17/24.
//

import UIKit

protocol AuthenticationDelegate: class {
    func authenticationComplete() 
}

class LoginController: UIViewController {
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    weak var delegate: AuthenticationDelegate?
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var emailContainerView = InputContainerView(#imageLiteral(resourceName: "ic_mail_outline_white_2x"), emailTextField)
    
    private lazy var passwordContainerView = InputContainerView(#imageLiteral(resourceName: "ic_lock_outline_white_2x"), passwordTextField)
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let passwordTextField: UITextField = {
        let tv = CustomTextField(placeholder: "Password")
        tv.isSecureTextEntry = true
        return tv
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributeTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradient()
        configureUI()
        
    }
    
    // MARK: - Selectors
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                return
            }
            
            self.dismiss(animated: true)
            self.delegate?.authenticationComplete()
        }
    }
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = .systemPurple
        
        view.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        dontHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
