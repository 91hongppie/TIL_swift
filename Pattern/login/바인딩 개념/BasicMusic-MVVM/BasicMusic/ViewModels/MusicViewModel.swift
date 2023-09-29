//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import Foundation

class MusicViewModel {
    
    var timer: Timer?
    
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
    
    // 데이터가 변했을때 알려주는 클로저 할당
    var onCompleted: (Music?) -> Void = { _ in }
    
    
    // Input
    func handleStartButtonTapped() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(fetchNewMusic),
                                     userInfo: nil, repeats: true)
    }
    
    func handleStopButtonTapped() {
        timer?.invalidate()
        timer = nil
    }
    
    // Logic
    // 타이머에 의해 실행되는 함수
    @objc func fetchNewMusic() {
        // 네트워킹 싱글톤으로 구현
        APIService.shared.fetchMusic { [weak self] result in
            switch result {
                case .success(let musics):
                    // 데이터 생성 완료 (API를 통해 다운로드 -> 파싱 완료된)
                    // 음악 데이터를 랜덤으로 ⭐️⭐️⭐️
                    self?.music = musics.randomElement()
                    
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
    
    deinit {
        timer = nil
    }
}
