//
//  Extensions.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 16/11/23.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexV = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexV.hasPrefix("#") {
            hexV.remove(at: hexV.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexV).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Int {
    var toString: String {
        return "\(self)"
    }
}

extension UIBarButtonItem {
    static func createBarButtonImage(
        _ image: UIImage,
        frame: (width: Double, height: Double)
    ) -> UIBarButtonItem {
        let logo = image
        logo.withRenderingMode(.alwaysOriginal)
        
        let logoImage = UIImageView.init(image: logo)
        logoImage.contentMode = .scaleAspectFit
        
        let wAnchor = logoImage.widthAnchor.constraint(equalToConstant: frame.width)
        let hAnchor = logoImage.heightAnchor.constraint(equalToConstant: frame.height)
        wAnchor.isActive = true
        hAnchor.isActive = true
        
        return UIBarButtonItem.init(customView: logoImage)
    }
}

