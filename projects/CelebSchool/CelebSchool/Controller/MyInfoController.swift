//
//  MyInfoController.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/1/24.
//

import UIKit

class MyInfoController: UITableViewController {
    // MARK: - Properties
    
    
    private let headerView = MyInfoHeader(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        headerView.delegate = self
        tableView.tableHeaderView = headerView

        tableView.contentInsetAdjustmentBehavior = .automatic
        
       
    }
    
}

extension MyInfoController: MyInfoHeaderDelegate {
    func handleLogin() {
        let controller = LoginController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
