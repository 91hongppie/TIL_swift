//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var bmiValue = "0.0"

    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        height.text = "\(String(format: "%.1f", sender.value))m"
    }

    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weight.text = "\(String(format: "%.0f", sender.value))Kg"
    }
    
    @IBAction func calcluatedPressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        bmiValue = String(format: "%.1f", weight / pow(height, 2))
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = bmiValue
        }
    }

}

