//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import Foundation

class MusicViewModel {
    
    // 일부러 싱글톤으로 안 만듦
    let apiManager: NetworkType
    
    // 핵심 데이터(모델) ⭐️⭐️⭐️ (뷰모델이 가지고 있음)
    var music: Music? {
        didSet {
            onCompleted(self.music)
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
    
    
    // 의존성 주입 ⭐️⭐️⭐️
    init(apiManager: NetworkType) {
        self.apiManager = apiManager
    }
    
    
    // Input
    func handleButtonTapped() {
        apiManager.fetchMusic { [weak self] result in
            switch result {
                case .success(let musics):
                    // 데이터 생성 완료 (API를 통해 다운로드 -> 파싱 완료된)
                    self?.music = musics.first
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

    
    func getDetailViewModel() -> DetailViewModel {
        // 의존성 주입 ⭐️⭐️⭐️
        let detailVM = DetailViewModel(apiService: self.apiManager)

        detailVM.music = self.music
        detailVM.imageURL = self.music?.imageUrl

        return detailVM
    }
    
}
