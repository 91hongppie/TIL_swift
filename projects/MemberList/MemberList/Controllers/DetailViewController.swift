//
//  DetailViewController.swift
//  MemberList
//
//  Created by Kyuhong Jo on 2023/09/02.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    
    var member: Member? {
        didSet {
            detailView.member = member
        }
    }
    
    override func loadView() {
        // super.loadView 이런 것은 필요없음 완전히 재정의하는 구간이기 때문에
        view = detailView
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // 뷰에 있는 버튼의 타겟 설정
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        print("버튼이 눌림")
    }
}
