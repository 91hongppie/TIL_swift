//
//  InputContainerView.swift
//  FireChatReview
//
//  Created by Kyuhong Jo on 12/12/23.
//

import UIKit

class InputContainerView: UIView {
    init(image: UIImage?, textField: UITextField) {
        super.init(frame: .zero)
        setHeight(height: 50)
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        iv.alpha = 0.87
        
        addSubview(iv)
        iv.centerY(inView: self)
        iv.anchor(left: leftAnchor, paddingLeft: 8)
        iv.setDimensions(height: 24, width: 24)
        
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: iv.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, paddingBottom: -8)
        
        let divideView = UIView()
        divideView.backgroundColor = .white
        addSubview(divideView)
        divideView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 0, height: 0.75)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
