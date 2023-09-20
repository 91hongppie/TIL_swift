//
//  BMIViewModel.swift
//  BMI
//
//  Created by Allen H on 2022/11/14.
//

import Foundation
import UIKit.UIColor

enum ValidationText: String {
    case right = "키와 몸무게를 입력하세요"
    case notRight = "키와 몸무게를 입력하셔야만 합니다!"
    
    var textColor: UIColor {
        switch self {
        case .right:
            return .black
        case .notRight:
            return .red
        }
    }
}

class BMIViewModel {
    
    var logicMananager: CalculatorType
    
    // 뷰를 위한 데이터
    private var mainText: ValidationText = .right
    
    private var heightString: String = ""
    private var weightString: String = ""
    
    private var bmi: BMI?
    
    //Output
    var mainTextString: String {
        return mainText.rawValue
    }
    
    var mainLabelTextColor: UIColor {
        return mainText.textColor
    }
    
    var bmiNumberString: String {
        return String(bmi?.value ?? 0.0)
    }
    
    var bmiAdviceString: String {
        return bmi?.advice ?? ""
    }
    
    var bmiColor: UIColor {
        return bmi?.matchColor ?? UIColor.white
    }
    
    
    init(logicMananager: CalculatorType) {
        self.logicMananager = logicMananager
    }
    
    //Input
    func setHeightString(_ height: String) {
        self.heightString = height
    }
    
    func setWeightString(_ weight: String) {
        self.weightString = weight
    }
    
    func handleButtonTapped(storyBoard: UIStoryboard?, fromCurrentVC: UIViewController, animated: Bool) {
        if self.makeBMI() {
            heightString = ""
            weightString = ""
            goToNextVC(storyBoard: storyBoard, fromCurrentVC: fromCurrentVC, animated: animated)
        } else {
            print("다음화면으로 갈 수 없음")
        }
    }
    
    
    //Logic
    private func makeBMI() -> Bool {
        do {
            bmi = try logicMananager.calculateBMI(height: self.heightString, weight: self.weightString)
            return true
        } catch {
            let er = error as! CalculateError
            switch er {
                case .minusNumberError:
                    print("마이너스 숫자 입력")
                case .noNumberError:
                    print("숫자가 아닌 글자 입력")
                default:
                    break
            }
            mainText = .notRight
            return false
        }
    }
    
    func resetBMI() {
        heightString = ""
        weightString = ""
        
        bmi = nil
        mainText = .right
    }
    
    // 다음화면으로 이동 ⭐️
    private func goToNextVC(storyBoard: UIStoryboard?, fromCurrentVC: UIViewController, animated: Bool) {
        
        // 스토리보드 생성 + 커스텀 생성자 ⭐️⭐️⭐️
        guard let secondVC = storyBoard?
            .instantiateViewController(identifier: "SecondViewController", creator: { coder in
                SecondViewController(coder: coder, viewModel: self) })
        else {
            fatalError("SecondViewController 생성 에러")
        }
        
        secondVC.modalPresentationStyle = .fullScreen
        fromCurrentVC.present(secondVC, animated: true, completion: nil)
    }
    
    
}
