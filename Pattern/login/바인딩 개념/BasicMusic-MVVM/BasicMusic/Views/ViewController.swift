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
        viewModel.handleStartButtonTapped()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        viewModel.handleStopButtonTapped()
    }
    
}

