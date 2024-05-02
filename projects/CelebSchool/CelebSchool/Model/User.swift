//
//  User.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/2/24.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let fullname: String
    
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
    }
}
