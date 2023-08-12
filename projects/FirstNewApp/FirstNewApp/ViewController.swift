//
//  ViewController.swift
//  FirstNewApp
//
//  Created by Kyuhong Jo on 2023/08/11.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    let step: Float = 5
    
    weak var timer: Timer?
    
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        number = 0
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
        timer?.invalidate()
    }


    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        let seconds = Int(sender.value * 60)
        mainLabel.text = "\(seconds) 초"
        number = seconds
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 1초씩 지나갈때마다 무언가를 실행
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            
            
            if number > 0 {
                number -= 1
                slider.value = Float(number) / Float(60)
                mainLabel.text = "\(number) 초"
            } else {
                number = 0
                timer?.invalidate()
                configureUI()
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
            
            
            
            
            
        }
     
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
//        slider.setValue(0.5, animated: true)
//        slider.value = 0.5
        configureUI()
    }
    
}

