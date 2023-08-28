//
//  DiceManager.swift
//  DiceGame
//
//  Created by Kyuhong Jo on 2023/08/25.
//

import UIKit

struct DiceManager {
    private var diceArray: [UIImage] = [ #imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6") ]
    
    func getRandomDice() -> UIImage {
        return diceArray.randomElement()!
    }
    
    func getFirstDice() -> UIImage {
        return diceArray[0]
    }
    
    func getDiceNum(num: Int) -> UIImage {
        return diceArray[num]
    }
}
