//
//  CalendarController.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/9/24.
//

import UIKit

class SettingController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        configureNavigationBar(withTitle: "모아보기", prefersLargeTitles: false)
        
    }
}

extension SettingController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
