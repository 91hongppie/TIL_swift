//
//  ViewController.swift
//  BMI
//
//  Created by Allen H on 2021/12/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    // BMI계산과 관련된 로직
    var bmiManager = BMICalculatorManager()
    
    // 데이터 (모델)
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightTextField.delegate = self
        weightTextField.delegate = self
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        calculateButton.layer.cornerRadius = 5
        heightTextField.placeholder = "cm단위로 입력해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }
    
    // BMI계산하기 - 버튼 누르면(다음화면)
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!!!"
            mainLabel.textColor = UIColor.red
        } else {
            mainLabel.text = "키와 몸무게를 입력해 주세요"
            mainLabel.textColor = UIColor.black
            
            let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
            
            self.bmi = bmiManager.calculateBMI(height: heightTextField.text!,
                                               weight: weightTextField.text!)
            secondVC.bmi = self.bmi
            
            secondVC.modalPresentationStyle = .fullScreen
            self.present(secondVC, animated: true)
            
            heightTextField.text = ""
            weightTextField.text = ""
        }
        
    }
    
    // 세그웨이로 구현 할때 =====================================
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if heightTextField.text == "" || weightTextField.text == "" {
//            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!!!"
//            mainLabel.textColor = UIColor.red
//            return false
//        }
//        mainLabel.text = "키와 몸무게를 입력해 주세요"
//        mainLabel.textColor = UIColor.black
//        return true
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toSecondVC" {
//            let secondVC = segue.destination as! SecondViewController
//            secondVC.modalPresentationStyle = .fullScreen
//            self.bmi = bmiManager.calculateBMI(height: heightTextField.text!,
//                                               weight: weightTextField.text!)
//            secondVC.bmi = self.bmi
//        }
//        heightTextField.text = ""
//        weightTextField.text = ""
//    }
    
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}

