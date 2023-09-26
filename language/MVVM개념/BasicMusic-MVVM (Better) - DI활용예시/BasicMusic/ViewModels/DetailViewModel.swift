//
//  DetailViewModel.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit


class DetailViewModel {
    
    let apiService: NetworkType
    
    var music: Music?
    
    var imageURL: String? {
        didSet {
            loadImage()
        }
    }
    
    // 뷰를 위한 데이터 (Output)
    var albumImage: UIImage? {
        didSet {
            onCompleted(albumImage)
        }
    }
    
    // Ouput
    var songNameString: String? {
        return music?.songName
    }
    
    var onCompleted: (UIImage?) -> Void = { _ in }
    
    
    // 의존성 주입 ⭐️⭐️⭐️
    init(apiService: NetworkType) {
        self.apiService = apiService
    }
    
    
    // Input (데이터를 변하게 하기 위한 로직)
    
    
    // Logic
    func loadImage() {
        apiService.loadImage(imageURL: self.imageURL) { [weak self] image in
            self?.albumImage = image
        }
    }

    
}
