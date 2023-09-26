//
//  APIService.swift
//  BasicMusic
//
//  Created by Kyuhong Jo on 2023/09/26.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    init() {}
    
    // Logic
    // 네트워킹 관련 함수도 뷰컨트롤러가 가지고 있음(일반적으로 분리)
    func fetchMusic(completion: @escaping (Result<Music?, NetworkError>) -> Void) {
        let urlString = "https://itunes.apple.com/search?media=music&term=jazz"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let musicData = try JSONDecoder().decode(MusicData.self, from: safeData)
                let music = musicData.results.first
                completion(.success(music))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
        
    }
}
