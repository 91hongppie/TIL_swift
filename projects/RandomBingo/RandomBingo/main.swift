//
//  main.swift
//  RandomBingo
//
//  Created by Kyuhong Jo on 2023/08/07.
//

import Foundation


var computerChoice = Int.random(in: 1...100)

var myChoice: Int = 0

while myChoice != computerChoice {
    
    var userInput = readLine()
    
    //guard let input = userInput else {
    //    return
    //}
    if let input = userInput {
        if let number = Int(input) {
            myChoice = number
        }
    }
    
    //print(myChoice)
    if computerChoice > myChoice {
        print("UP")
    } else if computerChoice < myChoice {
        print("DOWN")
    } else {
        print("BINGO!!")
    }
    
    
}
