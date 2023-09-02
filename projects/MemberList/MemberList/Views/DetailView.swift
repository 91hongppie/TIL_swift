//
//  DetailView.swift
//  MemberList
//
//  Created by Kyuhong Jo on 2023/09/02.
//

import UIKit

class DetailView: UIView {

    // MARK: - UI구현
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 정렬을 깔끔하게 하기 위한 컨테이너뷰
}
