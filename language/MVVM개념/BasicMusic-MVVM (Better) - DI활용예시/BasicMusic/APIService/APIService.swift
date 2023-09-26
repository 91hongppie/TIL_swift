//
//  APIService.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import Foundation
import UIKit

protocol NetworkType {
    func fetchMusic(completion: @escaping (Result<[Music], NetworkError>) -> Void)
    func loadImage(imageURL: String?, completion: @escaping (UIImage?) -> Void)
}

// 일부러 싱글톤으로 안 만듦
class APIService: NetworkType {
    func fetchMusic(completion: @escaping (Result<[Music], NetworkError>) -> Void) {
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
                completion(.success(musicData.results))
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
            
            DispatchQueue.main.async {
                completion(image)
                return
            }
        }
    }
}

