//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Kyuhong Jo on 2023/06/17.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

// struct를 위한 파일을 만들 때 struct와 같은 이름으로 만든다.
struct Question {
    let q: String
    let a: [String]
    let correctAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        self.q = q
        self.a = a
        self.correctAnswer = correctAnswer
    }
}
