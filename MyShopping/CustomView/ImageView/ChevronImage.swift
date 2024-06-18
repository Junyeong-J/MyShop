//
//  ChevronImage.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit

class ChevronImage: UIImageView {
    
    init(){
        super.init(frame: .zero)
        image = UIImage(systemName: "chevron.right")
        tintColor = Color.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
