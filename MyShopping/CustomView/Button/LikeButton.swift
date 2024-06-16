//
//  LikeButton.swift
//  MyShopping
//
//  Created by 전준영 on 6/17/24.
//

import UIKit

class LikeButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .light)
        let image = UIImage(systemName: "bag.fill", withConfiguration: imageConfig)
        backgroundColor = Color.blackAlpha50
        setImage(image, for: .normal)
        tintColor = .white
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
