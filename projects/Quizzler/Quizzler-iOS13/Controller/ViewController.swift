//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    var quizBrain = QuizBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBAction func answerButtonPress(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle
        let userGotItRight = quizBrain.checkAnswer(userAnswer!)
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    func buttonsClear() {
        answerOne.backgroundColor = UIColor.clear
        answerTwo.backgroundColor = UIColor.clear
        answerThree.backgroundColor = UIColor.clear
    }
    
    func setButtonsTitle() {
        answerOne.setTitle(quizBrain.getFirstAnswer(), for: .normal)
        answerTwo.setTitle(quizBrain.getSecondAnswer(), for: .normal)
        answerThree.setTitle(quizBrain.getThirdAnswer(), for: .normal)
        
    }
    
    @objc func updateUI() {
        //        questionLabel.text = quiz[questionNumber].text
        questionLabel.text = quizBrain.getQuestionText()
        setButtonsTitle()
        
        
        //        progressBar.progress = Float((questionNumber + 1)) / Float(quiz.count)
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        progressBar.progress = quizBrain.getProgress()
        buttonsClear()
    }
}

