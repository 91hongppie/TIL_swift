//
//  GoogleService.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/7/24.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

struct GoogleService {
    static let shared = GoogleService()
    
    func connectGoogle(signInResult: GIDSignInResult?, completion: @escaping((_ dictionary: [String: Any]) -> Void)) {
        // If sign in succeeded, display the app's main content View.
        let email = signInResult?.user.profile?.email ?? ""
        let name = signInResult?.user.profile?.name ?? ""
        let user = signInResult?.user
        let idToken = user?.idToken?.tokenString
        guard let refreshToken = user?.refreshToken.tokenString else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let accessToken = user?.accessToken.tokenString else { return }
        
        let token = "Bearer \(accessToken)"
        guard let API_KEY = Environment.youtubeAPIKey else { return }
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/channels?part=snippet,statistics&mine=true&key=\(API_KEY)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                print("DEBUG: failed to get youtube")
                return
            }
            
            guard let data = data else { return }
            
            guard let json = try? JSONDecoder().decode(ChannelListResponse.self, from: data) else { return }
            let subscriberNums = Int(json.items[0].statistics.subscriberCount) ?? 0
            let channelName = json.items[0].snippet.title
            let thumbnailURLString = json.items[0].snippet.thumbnails.default.url
            let channelId = json.items[0].id
            
            let dictionary = [
                "email": email,
                "subscriberNums": subscriberNums,
                "channelName": channelName,
                "thumbnailURLString": thumbnailURLString,
                "channelId": channelId,
                "refreshToken": refreshToken,
                "accessToken": accessToken
            ]
            completion(dictionary)
            
        }.resume()
    }
    
    func refreshAccessToken(user: User, index: Int, completion: @escaping(_ dictionary: [UserGoogleInfo]) -> Void) {
        guard let CLIENT_ID = Environment.clientId else { return }
        guard let API_KEY = Environment.youtubeAPIKey else { return }
        let REFRESH_TOKEN = user.google?[index].refreshToken
        
      
        // 여기서 뭐가 문젠지 찾아보려고 파라미터 하나씩 지워보다가 client_secret 지웠을 때 성공함..
        guard let url = URL(string: "https://oauth2.googleapis.com/token?grant_type=refresh_token&refresh_token=\(REFRESH_TOKEN)&client_id=\(CLIENT_ID)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                print("Failed refresh access token")
                return
            }
            guard let data = data else { return }
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let uid = Auth.auth().currentUser?.uid else { return }
            guard let newAccessToken = json["access_token"] else { return }
            
            guard var googleInfo = user.google else { return }
            var dictionary = [
                "email": user.google?[index].email,
                "subscriberNums": user.google?[index].subscriberNums,
                "channelName": user.google?[index].channelName,
                "thumbnailURLString": user.google?[index].thumbnailURLString,
                "channelId": user.google?[index].channelId,
                "refreshToken": user.google?[index].refreshToken,
                "accessToken": newAccessToken
            ]
            googleInfo[index] = UserGoogleInfo(dictionary: dictionary)
            completion(googleInfo)
            
        }.resume()
    }
}
