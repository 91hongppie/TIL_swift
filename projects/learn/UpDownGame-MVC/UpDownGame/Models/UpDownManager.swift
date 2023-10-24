//
//  UpDownManager.swift
//  UpDownGame
//
//  Created by Kyuhong Jo on 2023/08/25.
//

import Foundation

struct UpDownManager {
    
    private var comNumber = Int.random(in: 1...10)
    
    private var myNumber: Int = 1
    
    mutating func resetNum() {
        comNumber = Int.random(in: 1...10)
        myNumber = 1
    }
    
    mutating func setUsersNum(num: Int) {
        myNumber = num
    }
    
    func getUpDownResult() -> String {
        if comNumber > myNumber {
            return "Up"
        } else if comNumber < myNumber {
            return "Down"
        } else {
            return "Bingo!"
        }
    }
}
