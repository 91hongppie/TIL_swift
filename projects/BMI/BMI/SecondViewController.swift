//
//  SecondViewController.swift
//  BMI
//
//  Created by Kyuhong Jo on 2023/08/21.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
    }
    
    func makeUI() {
        
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    
    

}
