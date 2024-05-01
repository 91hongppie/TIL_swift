//
//  TabBarController.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/1/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        addVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        tabBar.tintColor = .systemPink
        tabBar.backgroundColor = .systemGray5
    }

    func addVC() {
        let firstVC = HomeController()
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName:"house.fill"))
        
        let secondVC = MyInfoController()
        secondVC.tabBarItem = UITabBarItem(title: "내 정보", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName:"person.crop.circle.fill"))
        
        self.viewControllers = [firstVC, secondVC]
    }
}
