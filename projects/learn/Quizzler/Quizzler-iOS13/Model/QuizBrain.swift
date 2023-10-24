//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Kyuhong Jo on 2023/06/17.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    let quiz = [
        Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
        
    ]
    
    var questionNumber = 0
    var score = 0
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].correctAnswer {
            // User got it right
            addScore()
            return true
        } else {
            // User got it wrong
            return false
        }
    }
    
    func getScore () -> Int {
        return score
    }
    
    mutating func addScore() {
        self.score += 1
    }
    
    mutating func initScore() {
        self.score = 0
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].q
    }
    
    func getProgress() -> Float {
        return Float((questionNumber + 1)) / Float(quiz.count)
    }
    
    func getFirstAnswer() -> String {
        return quiz[questionNumber].a[0]
    }
    
    func getSecondAnswer() -> String {
        return quiz[questionNumber].a[1]
    }
    
    func getThirdAnswer() -> String {
        return quiz[questionNumber].a[2]
    }
    
    mutating func nextQuestion() {
        self.questionNumber += 1
        if self.questionNumber == quiz.count {
            initScore()
            self.questionNumber = 0
        }
        
    }

}
