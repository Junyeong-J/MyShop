//
//  BagImage.swift
//  MyShopping
//
//  Created by 전준영 on 6/17/24.
//

import UIKit

class BagImage: UIImageView {
    
    init(){
        super.init(frame: .zero)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 13)
        let sfImage = UIImage(systemName: "bag.fill", withConfiguration: configuration)
        image = sfImage
        contentMode = .center
        tintColor = Color.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
