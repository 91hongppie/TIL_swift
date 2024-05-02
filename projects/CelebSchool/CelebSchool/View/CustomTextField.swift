//
//  CustomTextInput.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/2/24.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        
        font = .systemFont(ofSize: 16)
        textColor = .black
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.lightGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
