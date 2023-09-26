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
    
    var apiManager: APIService?
    
    // 데이터(모델) (일반적으로 뷰컨트롤러가 가지고 있음)
    //var music: Music?
    
    var songName: String?
    
    // 이미지 주소만 전달받고, 화면에 들어오면 다운로드 시작
    var imageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //loadImage()
    }
    
    func configureUI() {
        //self.songNameLabel.text = self.music?.songName
        self.songNameLabel.text = self.songName
        
        // 이미지 다운로드 (API매니저 사용)
        apiManager?.loadImage(imageURL: self.imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.albumImageView.image = image
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

