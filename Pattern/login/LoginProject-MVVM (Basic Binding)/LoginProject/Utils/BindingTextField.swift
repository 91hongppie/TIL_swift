//
//  BindingTextField.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/14.
//

import UIKit


class 바인딩기능있는텍스트필드: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonAddTarget()
    }
    
    // 스토리보드 생성시 호출
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonAddTarget()
    }
    
    // addTarget ===> 메서드 호출
    private func commonAddTarget() {
        self.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    // 글자가 변할때마다 호출되는 메서드 ⭐️⭐️⭐️
    @objc func textFieldDidChanged(_ textField: UITextField) {
        if let text = textField.text {
            나중에호출될수있는함수(text)
        }
    }
    
    // 글자가 변할때마다 클로저 호출
    private var 나중에호출될수있는함수: (String) -> Void = { _ in }
    
    
    func 바인딩하기(callback: @escaping (String) -> Void) {
        나중에호출될수있는함수 = callback
    }
}
