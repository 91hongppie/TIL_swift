//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Kyuhong Jo on 2023/08/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func button(_ sender: UIButton) {
        if textLabel.text == "반갑습니다." {
            textLabel.text = "안녕하세용."
        } else {
            textLabel.text = "반갑습니당."
        }
    }
    
}

