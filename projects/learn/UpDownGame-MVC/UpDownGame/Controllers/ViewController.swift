//
//  ViewController.swift
//  UpDownGame
//
//  Created by Kyuhong Jo on 2023/08/07.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    var upDownManager = UpDownManager()
    // 컴퓨터가 랜덤으로 숫자 선택 (1...10)
    var comNumber: Int?
    
    // 내가 선택한 숫자를 담는 변수
//    var myNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1) 메인레이블에 "선택하세요" 표시하기
//        mainLabel.text = "선택하세요"
        // 2) 숫자 레이블은 "" (빈문자열)
//        numberLabel.text = ""
        // 3) 컴퓨터가 랜덤 숫자를 선택하도록 하기
        refresh()
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // 1) 버튼의 숫자를 가져와야한다.
        guard let numString = sender.currentTitle else { return }
        // 2) 숫자 레이블이 변하도록 (숫자에 따라)
        numberLabel.text = numString
        
        // 3) 선택한 숫자를 변수에 저장 (선택) 문자열 --> 숫자로 변환한 다음 저장
        guard let num = Int(numString) else { return }
        upDownManager.setUsersNum(num: num)
        
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        // 1) 컴퓨터의 숫자와 내가 선택한 숫자를 비교 UP / Down / Bingo (메인레이블)
        guard let myNumString = numberLabel.text,
            let myNumber = Int(myNumString) else {
            return
            
        }

        
        upDownManager.setUsersNum(num: myNumber)
        mainLabel.text = upDownManager.getUpDownResult()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        refresh()
    }
    
    func refresh() {
        mainLabel.text = "선택하세요"
        numberLabel.text = ""
        comNumber = Int.random(in: 1...10)
    }
    
    
    
}

