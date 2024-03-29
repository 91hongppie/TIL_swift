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
        
        textField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        // textField.resignFirstResponder()
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
        let maxLength = 10
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
        
        // 입력되고 있는 글자가 "숫자"인 경우 입력을 허용하지 않는 논리
//        if Int(string) != nil { // 숫자로 변환이 된다면 nil이 아닐테니
//            return false
//        } else {
//            // 10글자이상 입력되는 것을 막는 코드
//            guard let text = textField.text else { return true }
//            let newLength = text.count + string.count - range.length
//            return newLength <= 10
//        }
//
        // 10글자 이상 입력되는 것을 막는 코드 (또다른 구현법)
//        if (textField.text?.count)! + string.count > 10 {
//            return false
//        } else {
//            return true
//        }
        
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
        textField.resignFirstResponder()
    }
    
    
    
}

