//
//  AppTitleLabel.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit

class AppTitleLabel: UILabel {
    
    init(title: String) {
        super.init(frame: .zero)
        
        text = title
        textColor = Color.myShopMainColor
        font = .systemFont(ofSize: 40, weight: .black)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
