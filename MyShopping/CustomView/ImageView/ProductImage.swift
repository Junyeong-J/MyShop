//
//  ProductImage.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit

class ProductImage: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        contentMode = .scaleAspectFit
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
