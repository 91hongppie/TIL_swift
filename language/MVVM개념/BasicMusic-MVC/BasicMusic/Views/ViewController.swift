//
//  ViewController.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var viewModel = MusicViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onCompleted = {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }
    }
    
    func configureUI() {
        self.albumNameLabel.text = viewModel.albumNameString
        self.songNameLabel.text = viewModel.songNameString
        self.artistNameLabel.text = viewModel.artistNameString
    }
    
    // 네트워킹 시작 (로직도 뷰컨트롤러가 가지고 있음)
    @IBAction func startButtonTapped(_ sender: UIButton) {
        viewModel.handleButtonTapped()
    }
    
    // 화면이동
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let music = self.viewModel.music else { return }
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        
        detailVC.modalPresentationStyle = .fullScreen
        
        // 다음화면에서 필요한 데이터 전달 ⭐️
        //detailVC.music = music
        detailVC.songName = music.songName
        detailVC.imageURL = music.imageUrl
        
        self.present(detailVC, animated: true)
    }
}
