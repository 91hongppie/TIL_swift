//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/23/24.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
