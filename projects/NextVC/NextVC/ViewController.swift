//
//  ViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 1) 코드로 화면 이동 (다음화면이 코드로 작성되어있을때만 가능한 방법)
    @IBAction func codeNextButtonTapped(_ sender: UIButton) {
        let firstVC = FirstViewController()
        firstVC.modalPresentationStyle = .fullScreen
        firstVC.someString = "We are!"
        
        /*
         스토리보드로 만들고 이런식으로 전달하면 에러가 발생한다.
         코드로 만들면 모든 저장속성이 한꺼번에 메모리에 올라간다.
         스토리보드로 만들면 코드로 된 ViewController을 메모리에 올리고
         그 다음에 스토리보드를 메모리에 올린다.
         그 다음에 코드랑 스토리보드를 연결하는 과정을 거친다.
         그래서 아래 방식으로 접근하면 메모리에 아직 올라가지 않았다는 에러가 발생한다.
         편하게 변수 만들어서 전달해서 사용하자.
        */
        // firstVC.mainLabel.text = "아기상어"
        
        present(firstVC, animated: true)

    }
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.someString = "아빠 상어"
        
        present(secondVC, animated: true)
        
        
    }
    
    
    
    // 3) 스토리보드에서의 화면 이동(간접 세그웨이)
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toThirdVC", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdVC" {
            let thirdVC = segue.destination as! ThirdViewController
            thirdVC.someString = "원피스"
        }
    }
    
}

