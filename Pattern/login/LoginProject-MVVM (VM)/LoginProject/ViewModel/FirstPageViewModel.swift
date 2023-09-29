//
//  FirstPageViewModel.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/14.
//

import Foundation

class FirstPageViewModel {
    
    // 데이터 (모델) ⭐️⭐️⭐️
    private var userEmail: String
    
    // Output
    var userEmailString: String {
        return userEmail
    }
    
    init(userEmail: String) {
        self.userEmail = userEmail
    }
    
    // Logic...
    
}
