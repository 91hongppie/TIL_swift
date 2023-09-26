//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import Foundation

class MusicViewModel {
    
    // 핵심 데이터(모델) ⭐️⭐️⭐️ (뷰모델이 가지고 있음)
    var music: Music? {
        didSet {
            onCompleted(music)
        }
    }
    
    // 뷰를 위한 데이터 (Output)
    var albumNameString: String? {
        return music?.albumName
    }
    
    var songNameString: String? {
        return music?.songName
    }
    
    var artistNameString: String? {
        return music?.artistName
    }
    
    var onCompleted: (Music?) -> Void = { _ in }
    
    
    // Input (데이터를 변하게 하기 위한 로직)
    func handleButtonTapped() {
        fetchMusic { [weak self] result in
            switch result {
                case .success(let music):
                    // 데이터 생성 완료 (API를 통해 다운로드 -> 파싱 완료된)
                    self?.music = music
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
    
    
    // Logic (기타 순수 로직 등)
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
    
    
//    func getDetailViewModel() -> DetailViewModel {
//        let detailVM = DetailViewModel()
//
//        detailVM.music = self.music
//        detailVM.imageURL = self.music?.imageUrl
//
//        return detailVM
//    }

}
