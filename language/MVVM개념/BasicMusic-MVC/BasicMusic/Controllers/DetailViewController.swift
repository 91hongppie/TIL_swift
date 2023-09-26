//
//  DetailViewController.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    
    // 데이터(모델) (일반적으로 뷰컨트롤러가 가지고 있음)
    //var music: Music?
    
    var songName: String?
    
    // 이미지 주소만 전달받고, 화면에 들어오면 다운로드 시작
    var imageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadImage()   //화면에 들어오면 다운로드 시작
    }
    
    func configureUI() {
        //self.songNameLabel.text = self.music?.songName
        self.songNameLabel.text = self.songName
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension DetailViewController {
    // 이미지 다운로드 하는 함수(메서드) 구현
    func loadImage() {
        guard let urlString = self.imageURL,
              let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),   // Data(contentsOf: url) 동기메서드 (직접 비동기처리 필요)
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.albumImageView.image = image
            }
        }
    }

}
