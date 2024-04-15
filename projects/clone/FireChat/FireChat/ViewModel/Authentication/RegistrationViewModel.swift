//
//  RegistrationViewModel.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/15/24.
//

import Foundation

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var fullname: String?
    var username: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false 
                && fullname?.isEmpty == false
                && username?.isEmpty == false
                && password?.isEmpty == false
    }
}
