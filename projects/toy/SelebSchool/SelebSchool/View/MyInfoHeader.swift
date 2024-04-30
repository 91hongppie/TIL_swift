//
//  SettingHeader.swift
//  SelebSchool
//
//  Created by Kyuhong Jo on 4/30/24.
//

import UIKit

protocol MyInfoHeaderDelegate: class {
    func handleLogin()
}

class MyInfoHeader: UIView {
    
    // MARK: - Properties
    
    weak var delegate: MyInfoHeaderDelegate?
    
    private let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .systemPink
        return button
    }()
    
    private let loginButton: UIButton = {
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
    
    func configureUI() {
        backgroundColor = .systemPurple

        
        addSubview(settingButton)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        settingButton.leftAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        loginButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }
}
