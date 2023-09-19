//
//  ViewController.swift
//  RPSGame
//
//  Created by Allen H on 2021/05/25.
//

import UIKit

class ViewController: UIViewController {

    // 변수 / 속성
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    let viewModel = RPSViewModel(rpsManager: RPSManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onCompleted = { [unowned self] resultString in
            self.comImageView.image = self.viewModel.computerRPSimage
            self.comChoiceLabel.text = self.viewModel.computerRPStext
            
            self.myImageView.image = self.viewModel.userRPSimage
            self.myChoiceLabel.text = self.viewModel.userRPStext

            self.mainLabel.text = resultString
        }
        
        viewModel.reset()
    }
    
    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        viewModel.rpsButtonTapped()
        
        guard let title = sender.currentTitle else { return }
        viewModel.userGetSelected(title: title)
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        viewModel.selectButtonTapped()
    }
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        viewModel.reset()
    }
    
    
    //    func configureUI() {
    //        comImageView.image = viewModel.computerRPSimage
    //        myImageView.image = viewModel.userRPSimage
    //
    //        comChoiceLabel.text = viewModel.computerRPStext
    //        myChoiceLabel.text = viewModel.userRPStext
    //
    //        mainLabel.text = viewModel.resultString
    //    }

}

