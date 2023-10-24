//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Kyuhong Jo on 2023/08/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        if mainLabel.text == "반갑습니당." {
            myButton.backgroundColor = .systemRed
            mainLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            mainLabel.text = "안녕하세용."
            mainLabel.textAlignment = .right
        } else {
            mainLabel.text = "반갑습니당."
            mainLabel.textColor = .blue
            mainLabel.textAlignment = .left
        }
    }
    
}

