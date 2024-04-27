//
//  MessageCell.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/26/24.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var message: Message? {
        didSet { configure() }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        tv.text = "Some test messages for now.."
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.translatesAutoresizingMaskIntoConstraints = false
        bubbleContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bubbleContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bubbleContainer.widthAnchor.constraint(equalToConstant: 250).isActive = true
        bubbleContainer.layer.cornerRadius = 15
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = true
        
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = true
        
        bubbleContainer.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: bubbleContainer.topAnchor, constant: 4).isActive = true
        textView.bottomAnchor.constraint(equalTo: bubbleContainer.bottomAnchor, constant: -4).isActive = true
        textView.leftAnchor.constraint(equalTo: bubbleContainer.leftAnchor, constant: 12).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleContainer.rightAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)
        
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        
        profileImageView.isHidden = viewModel.shouldHideProfileImage
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}

