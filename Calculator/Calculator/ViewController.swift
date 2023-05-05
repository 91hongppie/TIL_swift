//
//  ViewController.swift
//  Calculator
//
//  Created by Kyuhong Jo on 2023/04/27.
//

import UIKit // 버튼이나 텍스트 필드


// 모든 MVC의 Controller은 UIViewController을 상속받아야 한다. 직접적으로든 간접적으로든
class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel! // 숫자가 나타나는 화면
    
    private var userIsInTheMiddleOfTyping = false // 유저가 첫 터치이거나 연산자를 터치한 경우 false
    
    @IBAction private func touchDigit(_ sender: UIButton) { // 0 ~ 9 까지의 버튼을 눌렀을 때 수행하는 함수
        let digit = sender.currentTitle! // 버튼에 표시된 숫자
        if userIsInTheMiddleOfTyping { // 첫 타이핑이 아닌지 여부
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit // 기존에 눌렀던 숫자 + 이번에 누른 숫자 ex)"3" + "5" = "35"
        } else {
            display.text = digit // 처음이거나 연산자를 누른 이후 처음 누른 숫자
        }
        userIsInTheMiddleOfTyping = true // 숫자를 터치하면 true로 변환
        
        
    }
    
    private var displayValue: Double { // 화면에 표시될 값
        get {
            return Double(display.text!)! //
        }
        set {
            display.text = String(newValue) // 새로 들어오는 값이 문자열로 디스플레이에 표시될 값으로
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    @IBAction func save() { // save 버튼을 누른 경우
        savedProgram = brain.program // brain.program은 여태까지 계산한 값
    }
    @IBAction func restore() { // 가장 최근에 저장한 값으로 돌아가기
        if savedProgram != nil { // 저장된 값이 있다면
            brain.program = savedProgram as AnyObject // brain.program은 여태까지 계산한 값으로 변환
            displayValue = brain.result // 디스플레이에 표시되는 값은
        }
    }
    private var brain = CalculatorBrain() // 모델 불러오기
    
    @IBAction private func performOperation(_ sender: UIButton) { // 연산자를 클릭했을때 호출하기 위한 함수
        if userIsInTheMiddleOfTyping { // 유저가 숫자를 타이핑 중이라면
            brain.setOperand(displayValue) // 누른 숫자들 세팅
            userIsInTheMiddleOfTyping = false
        }
        if let mathmaticalSymbol = sender.currentTitle {
            brain.performOperation(mathmaticalSymbol)
        }
        displayValue = brain.result
    }
    
}


