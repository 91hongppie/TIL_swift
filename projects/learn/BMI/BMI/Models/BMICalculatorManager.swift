//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by Kyuhong Jo on 2023/08/23.
//

import UIKit


struct BMICalculatorManager {
    
    // BMI계산 결과값 저장 변수
    private var bmi: BMI?
    
    mutating func getBMI(height: String, weight: String) -> BMI {
        calculateBMI(height: height, weight: weight)
        
        return bmi ?? BMI(value: 0.0, matchColor: .white, advice: "문제발생")
    }
    
    mutating func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, matchColor: .white, advice: "문제발생")
            return
        }
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor.cyan
            bmi = BMI(value: bmiNum, matchColor: color, advice: "저체중")
        case 18.6..<23.0:
            let color = UIColor.systemPink
            bmi = BMI(value: bmiNum, matchColor: color, advice: "표준")
        case 23.0..<25.0:
            let color = UIColor.systemGreen
            bmi = BMI(value: bmiNum, matchColor: color, advice: "과체중")
        case 25.0..<30.0:
            let color = UIColor.systemGray
            bmi = BMI(value: bmiNum, matchColor: color, advice: "중도비만")
        case 30.0...:
            let color = UIColor.systemRed
            bmi = BMI(value: bmiNum, matchColor: color, advice: "고도비만")
        default:
            let color = UIColor.black
            bmi = BMI(value: bmiNum, matchColor: color, advice: "문제발생")
        }
    }
    
    
    //    // BMI 계산 메서드
    //    mutating func calculateBMI(height: String, weight: String) {
    //        guard let h = Double(height), let w = Double(weight) else {
    //            bmi = 0.0
    //            return
    //        }
    //        let bmiNumber = w / (h * h) * 10000
    //        print("BMI결과값(반올림 전): \(bmiNumber)")
    //        bmi = round(bmiNumber * 10) / 10
    ////        print("BMI결과값(반올림 후): \(self.bmi)")
    //    }
    //
    //    func getBMIResult() -> BMI {
    //        return bmi ?? BMI(value: 0.0, matchColor: .white, advice: "문제발생")
    //    }
    //
    //    // 색깔 얻는 메서드
    //    func getBackgroundColor() -> UIColor {
    //        guard let bmi = bmi else { return UIColor.black }
    //        switch bmi {
    //        case ..<18.6:
    //            return .cyan
    //        case 18.6..<23.0:
    //            return .systemPink
    //        case 23.0..<25.0:
    //            return .systemGreen
    //        case 25.0..<30.0:
    //            return .systemGray
    //        case 30.0...:
    //            return .systemRed
    //        default:
    //            return .black
    //        }
    //    }
    //
    //    // 문자열 얻는 메서드
    //    func getBMIAdviceString() -> String {
    //        guard let bmi = bmi else { return "" }
    //        switch bmi {
    //        case ..<18.6:
    //            return "저체중"
    //        case 18.6..<23.0:
    //            return "표준"
    //        case 23.0..<25.0:
    //            return "과체중"
    //        case 25.0..<30.0:
    //            return "중도비만"
    //        case 30.0...:
    //            return "고도비만"
    //        default:
    //            return ""
    //        }
    //    }
}
