//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Kyuhong Jo on 2023/09/26.
//

import Foundation

class MusicViewModel {
    
    // 데이터(모델) (일반적으로 뷰컨트롤러가 가지고 있음)
    var music: Music? {
        didSet {
            onCompleted()
        }
    }
    
    var onCompleted: () -> () = {}
    
    // Output
    var albumNameString: String? {
        return music?.albumName
    }
    
    var songNameString: String? {
        return music?.songName
    }
    
    var artistNameString: String? {
        return music?.artistName
    }
    
    // Input
    func handleButtonTapped() {
        APIService.shared.fetchMusic { [unowned self] result in
            switch result {
            case .success(let music):
                self.music = music
            case .failure(let error):
                switch error {
                case .dataError:
                    print("데이터 에러")
                case .networkingError:
                    print("네트워킹 에러")
                case .parseError:
                    print("파싱 에러")
                }
            }
        }
    }
    
//    // Logic
//    // 네트워킹 관련 함수도 뷰컨트롤러가 가지고 있음(일반적으로 분리)
//    func fetchMusic(completion: @escaping (Result<Music?, NetworkError>) -> Void) {
//        let urlString = "https://itunes.apple.com/search?media=music&term=jazz"
//        let url = URL(string: urlString)!
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                completion(.failure(.networkingError))
//                return
//            }
//
//            guard let safeData = data else {
//                completion(.failure(.dataError))
//                return
//            }
//
//            do {
//                let musicData = try JSONDecoder().decode(MusicData.self, from: safeData)
//                let music = musicData.results.first
//                completion(.success(music))
//            } catch {
//                completion(.failure(.parseError))
//            }
//        }.resume()
//
//    }
    
}
