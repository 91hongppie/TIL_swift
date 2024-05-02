//
//  InsertNicknameController.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/2/24.
//

import UIKit

class InsertInfoController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var nicknameInput = InputContainerView(title: "닉네임", textField: nicknameTextField)
    
    private let nicknameTextField = CustomTextField(placeholder: "3 ~ 7자로 입력해주세요.")
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        
        let stack = UIStackView(arrangedSubviews: [nicknameInput])
        
        stack.axis = .vertical
        stack.spacing = 10
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
