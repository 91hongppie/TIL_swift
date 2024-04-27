//
//  UserCell.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/23/24.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPurple
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Spider man"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Peter Parker"
        return label
    }()
    
    
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        profileImageView.layer.cornerRadius = 56 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let user = user else { return }
        fullnameLabel.text = user.fullname
        usernameLabel.text = user.username
        
        guard let url = URL(string: user.profileImageUrl) else { return }
        profileImageView.sd_setImage(with: url)
    }
}
