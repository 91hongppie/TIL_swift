//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Kyuhong Jo on 2023/06/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit


class ResultViewController: UIViewController {
    var resultValue: String?
    var splitValue: String?
    var tip: String?
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = resultValue
        settingsLabel.text = "Split between \(splitValue!) people, with \(tip!)% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
