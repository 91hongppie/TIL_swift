//
//  MyInfoHeader.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/1/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol MyInfoHeaderDelegate: class {
    func handleLogin()
}

class MyInfoHeader: UIView {
    
    // MARK: - Properties
    
    weak var delegate: MyInfoHeaderDelegate?
    
    var user: User? {
        didSet { updateConfigure() }
    }
    
    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.text = user?.fullname
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인 하러가기", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLogin() {
        delegate?.handleLogin()
    }
    
    // MARK: - Helpers
    
    func updateConfigure() {
        DispatchQueue.main.async {
            self.loginButton.isHidden = true
            
            self.addSubview(self.fullnameLabel)
            self.fullnameLabel.translatesAutoresizingMaskIntoConstraints = false
            self.fullnameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
            self.fullnameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        }
    }
    
    func configureUI() {
        backgroundColor = .white

        
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        loginButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }
}
