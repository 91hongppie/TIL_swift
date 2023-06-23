//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var percent: Double? = 0.1
    var result: Double? = 0.0
    var split: Int = 1
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        percent = 0.1
        split = 2
    }

    @IBAction func tipChange(_ sender: UIButton) {
        allUnselect()
        sender.isSelected = true
        billTextField.endEditing(true)
        if sender.currentTitle == "10%" {
            percent = 0.1
        } else if sender.currentTitle == "20%" {
            percent = 0.2
        } else {
            percent = 0.0
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        split = Int(sender.value)
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    func allUnselect() {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billValue = Double(billTextField?.text ?? "0.0") ?? 0
        let splitValue = Double(splitNumberLabel.text ?? "1") ?? 1
        print(splitValue)
        let resultPercent = percent ?? 1.0
        print(billValue, splitValue, resultPercent)
        result = (billValue + (billValue * resultPercent)) / splitValue
        print(result ?? 0.0)
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier ?? "")
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.resultValue = "\(String(format: "%.2f", result ?? 0.0))"
            destinationVC.splitValue = "\(String(split))"
            destinationVC.tip = "\(String(Int((percent ?? 0) * 100)))"
        }
    }
}

