//
//  CustomInputAccessoryView.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/25/24.
//

import UIKit

protocol CustomInputAccessoryDelegate: class {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
}


class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomInputAccessoryDelegate?
    
    private lazy var messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -0)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        sendButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(messageInputTextView)
        messageInputTextView.translatesAutoresizingMaskIntoConstraints = false
        messageInputTextView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        messageInputTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        messageInputTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        messageInputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -8).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leftAnchor.constraint(equalTo: messageInputTextView.leftAnchor, constant: 4).isActive = true
        placeholderLabel.centerYAnchor.constraint(equalTo: messageInputTextView.centerYAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 입력창을 safe area 내부에 놓이게 해준다.
    // intrinsicContentSize = view 본연의 사이즈
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Selectors
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
    
    @objc func handleSendMessage() {
        guard let message = messageInputTextView.text else { return }
        delegate?.inputView(self, wantsToSend: message)
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func clearMessageText() {
        DispatchQueue.main.async {
            self.messageInputTextView.text = nil
            self.placeholderLabel.isHidden = false
        }
        
    }
    
}

