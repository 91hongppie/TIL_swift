//
//  RPSManager.swift
//  RPSGame
//
//  Created by Allen H on 2021/12/12.
//

import Foundation

protocol RPSManagerProtocol {
    func getRpsResult(comChoice: Rps, myChoice: Rps) -> String
}


// 핵심 비즈니스 로직 (Domain)
class RPSManager: RPSManagerProtocol {
    
    func getRpsResult(comChoice: Rps, myChoice: Rps) -> String {
        if comChoice == myChoice {
            return "비겼다"
        } else if comChoice == .rock && myChoice == .paper {
            return "이겼다"
        } else if comChoice == .paper && myChoice == .scissors {
            return "이겼다"
        } else if comChoice == .scissors && myChoice == .rock {
            return "이겼다"
        } else {
            return "졌다"
        }
    }
    
}
