//
//  TipsyBrain.swift
//  Tipsy
//
//  Created by Kyuhong Jo on 2023/06/24.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

struct TipsyBrain {
    var percent: Double?
    var result: Double?
    var split: Double?
    
    init(percent: Double? = nil, result: Double? = nil, split: Double? = nil) {
        self.percent = percent
        self.result = result
        self.split = split
    }
    
    mutating func setPercent(percent: Double) {
        self.percent = percent
    }
    
    mutating func setSplit(split: Int) {
        self.split = Double(split)
    }
    
    mutating func calculateResult(bill: Double) {
        var resultPercent = percent ?? 0.0
        var resultSplit = split ?? 1.0
        result = (bill + (bill * resultPercent)) / resultSplit
    }
    
    func getResult() -> String {
        return "\(String(format: "%.2f", result ?? 0.0))"
    }
    
    func getSplit() -> String {
        return "\(String(Int(split ?? 0.0)))"
    }
    
    func getPercent() -> String {
        return "\(String(Int((percent ?? 0) * 100)))"
    }
}
