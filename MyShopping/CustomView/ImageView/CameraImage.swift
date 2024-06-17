//
//  CameraImage.swift
//  MyShopping
//
//  Created by 전준영 on 6/17/24.
//

import UIKit

class CameraImage: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 13)
        let sfImage = UIImage(systemName: "camera.fill", withConfiguration: configuration)
        image = sfImage
        contentMode = .center
        layer.cornerRadius = 15
        backgroundColor = Color.myShopMainColor
        tintColor = Color.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
