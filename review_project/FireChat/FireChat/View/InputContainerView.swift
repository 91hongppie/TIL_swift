//
//  InputContainerView.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/23/24.
//

import UIKit

class InputContainerView: UIView {
    init(_ image: UIImage, _ textField: UITextField) {
        super.init(frame: .zero)
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        iv.alpha = 0.87
        addSubview(iv)
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iv.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        iv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: 8).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        dividerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
