//
//  ProfileCell.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/29/24.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: ProfileViewModel? {
        didSet { configure() }
    }
    
    private lazy var iconView: UIView = {
        let view = UIView()
        
        view.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPurple
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.layer.cornerRadius = 40 / 2
        return view
    }()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 28).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 28).isActive = true
        iv.tintColor = .white
        
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        iconImage.image = UIImage(systemName: viewModel.iconImageName)
        titleLabel.text = viewModel.description
        
    }
}
