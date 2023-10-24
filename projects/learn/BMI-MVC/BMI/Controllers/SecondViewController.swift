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
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        bmiNumberLabel.text = "\(bmi!.value)"
        bmiNumberLabel.backgroundColor = bmi?.matchColor
        adviceLabel.text = bmi?.advice
        
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        
        backButton.layer.cornerRadius = 5
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
