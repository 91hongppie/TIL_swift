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
    let google: [UserGoogleInfo]?
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        var userGoogleInfos = [UserGoogleInfo]()
        if let googleInfos = dictionary["google"] as? [[String: Any]] {
            for googleInfo in googleInfos {
                userGoogleInfos.append(UserGoogleInfo(dictionary: googleInfo))
            }
        }
        self.google = userGoogleInfos.count != 0 ? userGoogleInfos : []
    }
}

struct UserGoogleInfos {
    
}

struct UserGoogleInfo {
    let email: String
    let channelId: String
    let channelName: String
    let subscriberNums: Int
    let thumbnailURLString: String
    let refreshToken: String
    let accessToken: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.channelId = dictionary["channelId"] as? String ?? ""
        self.channelName = dictionary["channelName"] as? String ?? ""
        self.subscriberNums = dictionary["subscriberNums"] as? Int ?? 0
        self.thumbnailURLString = dictionary["thumbnailURLString"] as? String ?? ""
        self.refreshToken = dictionary["refreshToken"] as? String ?? ""
        self.accessToken = dictionary["accessToken"] as? String ?? ""
        
    }
}
