//
//  MyTableViewCell.swift
//  MemberList
//
//  Created by Allen H on 2022/02/04.
//

import UIKit

final class MyTableViewCell: UITableViewCell {

    //MARK: - 멤버 저장속성 구현
//    var member: Member? {
//        didSet {
//            guard var member = member else { return }
//            mainImageView.image = member.memberImage
//            memberNameLabel.text = member.name
//            addressLabel.text = member.address
//        }
//    }
    
    //MARK: - 뷰모델
    
    var viewModel: MemberViewModel! {
        didSet {
            configureUI()
        }
    }
    
    //MARK: - UI구현
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    //MARK: - 생성자
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupStackView()

        // 오토레이아웃 생성자에서 잡으면 됨 ⭐️⭐️⭐️
        setConstraints()
    }
    
    func setupStackView() {
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(memberNameLabel)
        stackView.addArrangedSubview(addressLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 오토레이아웃 셋팅
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 40),
            mainImageView.widthAnchor.constraint(equalToConstant: 40),
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            mainImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            memberNameLabel.heightAnchor.constraint(equalToConstant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.mainImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.mainImageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor)
        ])
    }
    
    //MARK: - 레이아웃 셋팅 (자동)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainImageView.clipsToBounds = true
        self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 2
    }
    
    //MARK: - 뷰모델을 가지고 뷰 셋팅
    func configureUI() {
        mainImageView.image = viewModel.memberImage
        memberNameLabel.text = viewModel.nameString
        addressLabel.text = viewModel.addressString
    }
}
