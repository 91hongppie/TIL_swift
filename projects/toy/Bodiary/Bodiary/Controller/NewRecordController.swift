//
//  NewRecordController.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/9/24.
//

import UIKit

class NewRecordController: UIViewController {
    
    // MARK: - Properties
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .black
        configureNavigationBar(withTitle: "새 글 작성", prefersLargeTitles: false)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleDismiss))
        
        
        
    }
}
