//
//  SecondViewController.swift
//  BMI
//
//  Created by Allen H on 2021/12/12.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 전화면에서 전달받은 BMI를 저장하기 위한 변수
    var viewModel: BMIViewModel
    
    // (스토리보드) 커스텀 생성자 ⭐️⭐️⭐️
    init(coder: NSCoder, viewModel: BMIViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    func setupUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        backButton.layer.cornerRadius = 5
    }
    
    func configureUI() {
        // ViewModel이 가지고 있는 BMI 데이터
        bmiNumberLabel.text = viewModel.bmiNumberString
        bmiNumberLabel.backgroundColor = viewModel.bmiColor
        adviceLabel.text = viewModel.bmiAdviceString
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.viewModel.resetBMI()
        self.dismiss(animated: true, completion: nil)
    }

}
