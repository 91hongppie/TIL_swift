//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Kyuhong Jo on 2023/04/28.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Double> = [
        "pi": Double.pi,
        "e" : M_E
    ]
    
    
    func performOperation(symbol: String) {
        if let constant = operations[symbol] {
            accumulator = constant
        }
        
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
