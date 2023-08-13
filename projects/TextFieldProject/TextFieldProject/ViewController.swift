//
//  ViewController.swift
//  TextFieldProject
//
//  Created by Kyuhong Jo on 2023/08/12.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        setup()
    }
    
    func setup() {
        // view는 viewController에 해당하는 화면
        view.backgroundColor = .gray
        
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .next
    }
    
    // 텍스트필드의 입력을 시작할 때 호출되는 메서드 (시작할지 말지의 여부를 허락하는 것)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 시점 - 텍스트 필드에 입력이 시작된 시점 ( 텍스트필드를 눌렀을 때 )
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드의 입력을 시작했다.")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 글자 내용이 (한글자 한글자) 입력되거나 지워질 때 호출이 되고 (입력할지 말지 허락)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(#function)
        print(string)
        return true
    }

    // 텍스트필드의 엔터키가 눌러지면 다음 동작을 허락할지 여부
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        if textField.text == "" {
            textField.placeholder = "Type Something!"
            return false
        } else {
            return true
        }
    }
    
    // 텍스트 필드의 입력이 끝날때 호출 ( 끝나는 것에 대한 허락 여부)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }

    // 텍스트 필드의 입력이 끝나는 순간에 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드의 입력을 끝냈다.")
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
    }
    
    

}

