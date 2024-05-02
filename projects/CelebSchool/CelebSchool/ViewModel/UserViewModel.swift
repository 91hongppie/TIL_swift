//
//  UserViewModel.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/2/24.
//

import Foundation

struct UserViewModel {
    var uid: String?
    var email: String?
    var fullname: String?
    
    mutating func updateUser(user: User) {
        uid = user.uid
        email = user.email
        fullname = user.fullname
    }
    
    var formIsValid: Bool {
        return uid?.isEmpty == false && email?.isEmpty == false && fullname?.isEmpty == false
    }
}
