//
//  EmptyImage.swift
//  MyShopping
//
//  Created by 전준영 on 6/15/24.
//

import UIKit

class EmptyImage: UIImageView {
    
    init(title: String) {
        super.init(frame: .zero)
        image = UIImage(named: title)
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
