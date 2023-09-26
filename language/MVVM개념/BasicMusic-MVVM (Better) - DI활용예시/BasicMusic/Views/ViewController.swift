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
    
    var viewModel: MusicViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //반드시 삭제 ⭐️ (뷰모델 생성시 네트워크 모델 필요)
        //self.viewModel = MusicViewModel()
        
        // 데이터 변경이 완료된 후, 클로저에서 어떤 일을 할지 정의 (할당)
        self.viewModel.onCompleted = { [weak self] _ in
            DispatchQueue.main.async {
                self?.albumNameLabel.text = self?.viewModel.albumNameString
                self?.songNameLabel.text = self?.viewModel.songNameString
                self?.artistNameLabel.text = self?.viewModel.artistNameString
            }
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        viewModel.handleButtonTapped()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        guard viewModel.music != nil else { return }
        

        let detailVM = viewModel.getDetailViewModel()
        
        //다음 화면 뷰컨트롤러 ⭐️
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        
        //뷰모델 전달 ⭐️
        detailVC.viewModel = detailVM
        
        
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true)
    }
}

