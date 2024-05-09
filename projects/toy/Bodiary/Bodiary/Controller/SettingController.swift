//
//  CalendarController.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/9/24.
//

import UIKit

class SettingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        configureNavigationBar(withTitle: "설정", prefersLargeTitles: false)
        
    }
}
