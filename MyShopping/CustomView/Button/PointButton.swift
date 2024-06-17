//
//  PointButton.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit

class PointButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(Color.white, for: .normal)
        layer.cornerRadius = 25
        backgroundColor = Color.myShopMainColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
