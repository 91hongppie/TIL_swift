//
//  APIService.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit

// 일부러 싱글톤으로 안 만듦
class APIService {
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
    
    func loadImage(imageURL: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = imageURL,
              let url = URL(string: urlString)  else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // 이미지로 제대로 변환이 다 된 경우
            completion(image)
            return
        }
    }
}
