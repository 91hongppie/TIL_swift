//
//  RegistrationViewModel.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/23/24.
//

import Foundation

struct RegistrationViewModel {
    var email: String?
    var password: String?
    var username: String?
    var fullname: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false &&
            username?.isEmpty == false &&
            fullname?.isEmpty == false
    }
}
