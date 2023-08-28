//
//  ViewController.swift
//  DiceGame
//
//  Created by Kyuhong Jo on 2023/08/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    var diceManager = DiceManager()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstImageView.image = diceManager.getFirstDice()
        secondImageView.image = diceManager.getFirstDice()
        
    }

    
    @IBAction func rollButtonTapped(_ sender: UIButton) {
        firstImageView.image = diceManager.getRandomDice()
        secondImageView.image = diceManager.getRandomDice()
    }
    
    
    
    
    
}

