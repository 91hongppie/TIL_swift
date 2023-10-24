//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by Allen H on 2021/12/12.
//

import UIKit

enum CalculateError: Error {
    case noNumberError
    case minusNumberError
    case notAnError
}

protocol CalculatorType {
    func calculateBMI(height: String, weight: String) throws -> BMI
}


// 비즈니스 로직 담당 ⭐️⭐️⭐️
// (BMI계산과 관련된 로직만 담당 - Domain 로직)
struct BMICalculatorManager: CalculatorType {
    
    // BMI만들기 메서드(BMI수치 계산해서, BMI 리턴 메서드)
    func calculateBMI(height: String, weight: String) throws -> BMI {
        
        // 문자열을 숫자로 변환
        guard let h = Double(height), let w = Double(weight) else {
            throw CalculateError.noNumberError
        }
        
        // 0이상인지 확인
        guard h > 0, w > 0 else {
            throw CalculateError.minusNumberError
        }
        
        // BMI계산하기
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255,
                                green: 231/255,
                                blue: 207/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "저체중", matchColor: color)
            
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255,
                                green: 251/255,
                                blue: 121/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "표준", matchColor: color)
            
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255,
                                green: 127/255,
                                blue: 163/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "과체중", matchColor: color)
            
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255,
                                green: 150/255,
                                blue: 141/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "중도비만", matchColor: color)
            
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255,
                                green: 100/255,
                                blue: 78/255,
                                alpha: 1)
            return BMI(value: bmiNum, advice: "고도비만", matchColor: color)
            
        default:
            throw CalculateError.notAnError
        }
    }
    
}
