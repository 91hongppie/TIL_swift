//
//  RegistrationController.swift
//  FireChatReview
//
//  Created by Kyuhong Jo on 12/12/23.
//

import UIKit

class RegistrationController: UIViewController {
 
    // MARK: - Properties
    
    private let AlreadyHaveAccount: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        print("아하하하하")
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleShowLogin() {
        let controller = LoginController()
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helpers
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(AlreadyHaveAccount)
        AlreadyHaveAccount.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
}
