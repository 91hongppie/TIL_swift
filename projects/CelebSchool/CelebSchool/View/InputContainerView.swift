//
//  InsertInfoTextInput.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/2/24.
//

import UIKit

class InputContainerView: UIView {
    
    init(title: String, textField: UITextField) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 12)
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        let dividerView = UIView()
        dividerView.backgroundColor = .lightGray
        addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        dividerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        dividerView.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
