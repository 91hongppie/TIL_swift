//
//  Extension.swift
//  FireChat
//
//  Created by Kyuhong Jo on 4/22/24.
//

import UIKit

extension UIViewController {
    func configureGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}
