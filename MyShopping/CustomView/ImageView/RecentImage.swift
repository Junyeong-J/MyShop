//
//  RecentImage.swift
//  MyShopping
//
//  Created by 전준영 on 6/15/24.
//

import UIKit

class RecentImage: UIImageView {
    
    init() {
        super.init(frame: .zero)
        image = UIImage(systemName: "clock")
        tintColor = Color.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
