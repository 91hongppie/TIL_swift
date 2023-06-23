//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tipsyBrain: TipsyBrain?
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsyBrain = TipsyBrain(percent: 0.1, split: 2)
    }

    @IBAction func tipChange(_ sender: UIButton) {
        allUnselect()
        sender.isSelected = true
        billTextField.endEditing(true)
        if sender.currentTitle == "10%" {
            tipsyBrain?.setPercent(percent: 0.1)
        } else if sender.currentTitle == "20%" {
            tipsyBrain?.setPercent(percent: 0.1)
        } else {
            tipsyBrain?.setPercent(percent: 0.0)
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        tipsyBrain?.setSplit(split: Int(sender.value))
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    func allUnselect() {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billValue = Double(billTextField?.text ?? "0.0") ?? 0
        tipsyBrain?.calculateResult(bill: billValue)
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.resultValue = tipsyBrain?.getResult()
            destinationVC.splitValue = tipsyBrain?.getSplit()
            destinationVC.tip = tipsyBrain?.getPercent()
        }
    }
}

