//
//  ViewController.swift
//  TextFieldProject
//
//  Created by Kyuhong Jo on 2023/08/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        // view는 viewController에 해당하는 화면
        view.backgroundColor = .gray
        
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .go
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
    }
    
    

}

