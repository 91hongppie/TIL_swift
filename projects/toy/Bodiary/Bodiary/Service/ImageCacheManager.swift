//
//  ImageCacheManager.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/17/24.
//

import UIKit

class ImageCacheManager{
    static let shared = NSCache<NSString, UIImage>()
    private init (){}
}


