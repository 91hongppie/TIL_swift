//
//  ViewController.swift
//  Calculator
//
//  Created by Kyuhong Jo on 2023/04/27.
//

import UIKit // 버튼이나 텍스트 필드


// 모든 MVC의 Controller은 UIViewController을 상속받아야 한다. 직접적으로든 간접적으로든
class ViewController: UIViewController {
    @IBAction func touchDigit(_ sender: UIButton) {
        print("touchDigit")
    }
    
}

 
