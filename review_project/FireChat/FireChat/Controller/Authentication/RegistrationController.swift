//
//  RegistrationController.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/17/24.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var profileImage: UIImage?
    private var viewModel = RegistrationViewModel()
    weak var delegate: AuthenticationDelegate?

    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var emailContainerView = InputContainerView(#imageLiteral(resourceName: "ic_mail_outline_white_2x"), emailTextField)
    
    
    private lazy var passwordContainerView = InputContainerView(#imageLiteral(resourceName: "ic_lock_outline_white_2x"), passwordTextField)
    
    private lazy var usernameContainerView = InputContainerView(#imageLiteral(resourceName: "ic_person_outline_white_2x"), usernameTextField)
    
    private lazy var fullnameContainerView = InputContainerView(#imageLiteral(resourceName: "ic_person_outline_white_2x"), fullnameTextField)
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let passwordTextField: UITextField = {
       let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let usernameTextField = CustomTextField(placeholder: "Usernmae")
    
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradient()
        configureUI()
        configureNotificationObserver()
    }
    
    // MARK: - Selectors
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else  if sender == usernameTextField {
            viewModel.username = sender.text
        } else {
            viewModel.fullname = sender.text
        }
        
        checkFormStatus()
        
    }
    
    @objc func handleRegistration() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let profileImage = profileImage else { return }
        
        let credentials = RegistrationCredentials(email: email, password: password, username: username, fullname: fullname, profileImage: profileImage)
        
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                print("DEBUG: \(error)")
                return
            }
        
            print("completed Sign Up")
            self.dismiss(animated: true)
        }
        
    }
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.addSubview(addPhotoButton)
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addPhotoButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, usernameContainerView, fullnameContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 32).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
    
    }
    
    func configureNotificationObserver() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        profileImage = image
        addPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3.0
        addPhotoButton.layer.cornerRadius = 200 / 2
        dismiss(animated: true)
    }
}
