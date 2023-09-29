//
//  FirstPageViewController.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/14.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    let viewModel: FirstPageViewModel
    
    private let basicLabel: UILabel = {
        let label = UILabel()
        label.text = "기본글자"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 코드로 구현할때 뷰컨 생성자 ⭐️⭐️⭐️
    init(viewModel: FirstPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(basicLabel)
        self.view.backgroundColor = .lightGray
        setupAutoLayout()
        configureUI()
    }
    
    // 뷰모델에서 데이터 가져다가 표시 ⭐️⭐️⭐️
    private func configureUI() {
        self.basicLabel.text = viewModel.userEmailString
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            basicLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            basicLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            basicLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200)
        ])
    }

}
