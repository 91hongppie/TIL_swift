//
//  MyInfoGoogleCell.swift
//  CelebSchool
//
//  Created by Kyuhong Jo on 5/7/24.
//

import UIKit
import SDWebImage

class MyInfoGoogleCell: UITableViewCell {
    
    var googleInfo: UserGoogleInfo? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPink
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let channelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "MRBeast"
        return label
    }()
    
    private let subscribersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "25"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.layer.cornerRadius = 30 / 2
        
        let stack = UIStackView(arrangedSubviews: [channelNameLabel, subscribersLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let googleInfo = googleInfo else { return }
        channelNameLabel.text = googleInfo.channelName
        subscribersLabel.text = "구독자 \(googleInfo.subscriberNums)명"
        
        guard let url = URL(string: googleInfo.thumbnailURLString) else  { return }
        profileImageView.sd_setImage(with: url)
    }
    
}
