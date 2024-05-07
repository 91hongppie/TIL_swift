//
//  Constant.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/6/24.
//

import Foundation


struct Environment {
    static let youtubeAPIKey = Bundle.main.object(forInfoDictionaryKey: "youtubeAPIKey")
    static let clientId = Bundle.main.object(forInfoDictionaryKey: "GIDClientID")
}
