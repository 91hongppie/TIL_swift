//
//  User.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/23/24.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let profileImageUrl: String
    let username: String
    let fullname: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
    }
}
