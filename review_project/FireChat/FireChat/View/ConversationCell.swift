//
//  ConversationCell.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/27/24.
//

import UIKit

class ConversationCell: UITableViewCell {
    
    // MARK: - Properties
    
    var conversation: Conversation? {
        didSet { configure () }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "2h"
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        addSubview(timestampLabel)
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        timestampLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        timestampLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let conversation = conversation else { return }
        let viewModel = ConversationViewModel(conversation: conversation)
        
        usernameLabel.text = conversation.user.username
        messageTextLabel.text = conversation.message.text
        
        timestampLabel.text = viewModel.timestamp
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
