//
//  DetailViewModel.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit


class DetailViewModel {
    
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
    
    
    // Input (데이터를 변하게 하기 위한 로직)
    
    
    
    

    // Logic (기타 순수 로직 등) (APIService에 위치시켜도 됨)
    func loadImage() {
        guard let urlString = self.imageURL,
              let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.albumImage = image
            }
        }
    }
    
}
