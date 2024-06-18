//
//  LikeButton.swift
//  MyShopping
//
//  Created by 전준영 on 6/17/24.
//

import UIKit

class LikeButton: UIButton {
    
    init(backColor: UIColor, tint: UIColor) {
        super.init(frame: .zero)
        
        let bagImage = UIImage(named: "like_unselected")
        backgroundColor = backColor
        setImage(bagImage, for: .normal)
        tintColor = tint
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
