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
    
    var diceArray: [UIImage] = [ #imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6") ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstImageView.image = diceArray[1]
        secondImageView.image = diceArray[1]
        
    }

    
    @IBAction func rollButtonTapped(_ sender: UIButton) {
        firstImageView.image = diceArray.randomElement()
        secondImageView.image = diceArray.randomElement()
    }
    
    
    
    
    
}

