//
//  FirstPageViewModel.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/14.
//

import Foundation

class FirstPageViewModel {
    
    // 데이터 (모델) ⭐️⭐️⭐️
    var userEmail: 클래스로감싸진데이터<String>
    
    init(userEmail: String) {
        self.userEmail = 클래스로감싸진데이터(userEmail)
        print(self.userEmail.데이터값)
    }
    

}
