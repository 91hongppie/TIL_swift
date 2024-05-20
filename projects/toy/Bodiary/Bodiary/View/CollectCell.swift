//
//  CollectCell.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/17/24.
//

import UIKit


class CollectCell: UICollectionViewCell {
    var record: DailyRecord? {
        didSet {
            let cacheKey = NSString(string: "\(self.record?.timestamp)")
            if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
                guard let imageData = self.record?.image else { return }
                self.profileImage.image = cachedImage
                return
            }
            guard let imageData = record?.image, let image = UIImage(data: imageData) else { return }
            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
            self.profileImage.image = image
        }
    }
    
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.crop.square")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        profileImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        profileImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
