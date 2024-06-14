//
//  UILabel+Extension.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit

extension UILabel {
    
    func setUILabel(_ title: String, textAlignment: NSTextAlignment, color: UIColor, backgroundColor: UIColor, font: UIFont, cornerRadius: Double, numberLine: Int) {
        
        self.text = title
        self.textAlignment = textAlignment
        self.textColor = color
        self.font = font
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.numberOfLines = numberLine
        
    }
    
}
