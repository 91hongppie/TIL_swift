//
//  ProfileFooter.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/29/24.
//

import UIKit

protocol ProfileFooterDelegate: class {
    func handleLogout()
}

class ProfileFooter: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ProfileFooterDelegate?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
        delegate?.handleLogout()
    }    
}
