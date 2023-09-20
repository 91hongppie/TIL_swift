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
    
    // 데이터 + (로직) ===> 뷰모델 ⭐️⭐️⭐️
    let viewModel: BMIViewModel
    
    init(coder: NSCoder, viewModel: BMIViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - 라이프사이클
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.resetBMI()
        setupMainText()
    }
    
    func setup() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        heightTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    func configureUI() {
        viewModel.resetBMI()
        setupMainText()
        
        calculateButton.layer.cornerRadius = 5
        heightTextField.placeholder = "cm단위로 입력해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }
    
    // 세그웨이 삭제, 직접 인스턴스 생성 이동
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        viewModel.handleButtonTapped(storyBoard: self.storyboard, fromCurrentVC: self, animated: true)
        
        setupMainText()
        
        // 다음화면으로 갈때 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    func setupMainText() {
        mainLabel.text = viewModel.mainTextString
        mainLabel.textColor = viewModel.mainLabelTextColor
    }
    
    // 텍스트필드 입력값이 변할때마다 호출 ⭐️
    // 뷰모델에 알려주기 위함
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField == heightTextField {
            viewModel.setHeightString(textField.text ?? "")
        }
        if textField == weightTextField {
            viewModel.setWeightString(textField.text ?? "")
        }
    }
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

