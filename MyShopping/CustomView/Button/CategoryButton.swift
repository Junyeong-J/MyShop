//
//  CategoryButton.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit

class CategoryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(Color.black, for: .normal)
        titleLabel?.font = Font.regular15
        backgroundColor = Color.white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 15
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
