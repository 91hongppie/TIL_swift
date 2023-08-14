//
//  ViewController.swift
//  LoginProject
//
//  Created by Kyuhong Jo on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {
    
    let emailTextFieldView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        makeUI()
    }
    
    
    
    func makeUI() {
        emailTextFieldView.backgroundColor = .darkGray
        
        view.addSubview(emailTextFieldView)
        
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false // ⭐️⭐️⭐️
        
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
    }
    

}

