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
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        viewModel.onCompleted = { [weak self] albumImage in
            self?.albumImageView.image = albumImage
        }
        songNameLabel.text = viewModel.songNameString
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
