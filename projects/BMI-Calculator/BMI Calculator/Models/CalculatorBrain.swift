//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Kyuhong Jo on 2023/06/22.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain {

    var bmi: Float?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        bmi = weight / (height * height)
        
    }
    
    func getBMIValue() -> String {
        if bmi != nil {
            let bmiTo1DecimalPlace = String(format: "%.1f", bmi)
            return bmiTo1DecimalPlace
        } else {
            return "우하하"
        }
    }
}
