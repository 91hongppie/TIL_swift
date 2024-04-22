//
//  LoginController.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/17/24.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Properties
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        iv.tintColor = .white
        iv.alpha = 0.87
        view.addSubview(iv)
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iv.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        iv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let textField = emailTextField
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        view.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        dividerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        iv.tintColor = .white
        iv.alpha = 0.87
        view.addSubview(iv)
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iv.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        iv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let textField = passwordTextField
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        view.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        dividerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tv = UITextField()
        tv.borderStyle = .none
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textColor = .white
        tv.keyboardAppearance = .dark
        tv.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.white])
        return tv
    }()
    
    private let passwordTextField: UITextField = {
        let tv = UITextField()
        tv.borderStyle = .none
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textColor = .white
        tv.keyboardAppearance = .dark
        tv.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.white])
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
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
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
    }
    
    // MARK: - Helpers
}
