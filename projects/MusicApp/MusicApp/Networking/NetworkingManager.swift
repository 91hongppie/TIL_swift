//
//  NetworkingManager.swift
//  MusicApp
//
//  Created by Kyuhong Jo on 2023/09/16.
//

import Foundation


class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
   
    func fetchMusic() {
    }
    
    
    func getMethod(url: URL, completionHandler: @escaping ([Music]?) -> Void) {
        
        
        // URL구조체 만들기
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=jazz") else {
            print("Error: cannot create URL")
            completionHandler(nil)
            return
        }
        
        // URL요청 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 요청을 가지고 작업세션시작
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 없어야 넘어감
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                completionHandler(nil)
                return
            }
            // 옵셔널 바인딩
            guard let safeData = data else {
                print("Error: Did not receive data")
                completionHandler(nil)
                return
            }
            // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completionHandler(nil)
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                let musicData = try decoder.decode(MusicData.self, from: safeData)
                completionHandler(musicData.results)
            } catch {
                print(error)
            }
        }.resume()     // 시작
    }

    func parsing() -> [Music]? {
        
    }
}

