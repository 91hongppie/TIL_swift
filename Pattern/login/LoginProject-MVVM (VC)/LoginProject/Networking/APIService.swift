//
//  APIService.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/14.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case notAuthenticated
}

final class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    // 테스트 형태 ⭐️⭐️⭐️
    func loginTest(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        if username == "1234@gmail.com" && password == "1234" {
            completion(.success(()))
            return
        } else {
            completion(.failure(.notAuthenticated))
            return
        }
    }
    
    
    // 실제 API형태 ⭐️⭐️⭐️
    func login(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        let url = URL(string: "...")!
        
        let loginData = ["username": username, "password": password]
        
        // 리퀘스트 생성 (포스트)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginData)
        
        // with 리퀘스트 ===> URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                      completion(.failure(.badRequest))
                      return
                  }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            if loginResponse.success {
                completion(.success(()))
                return
            } else {
                completion(.failure(.notAuthenticated))
                return
            }
        }.resume()
    }
}
