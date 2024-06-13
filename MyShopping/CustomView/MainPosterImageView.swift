//
//  MainPosterImageView.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit

class MainPosterImageView: UIImageView {
    
    init(imageTitle: String) {
        super.init(frame: .zero)
        
        image = UIImage(named: imageTitle)
        contentMode = .scaleAspectFill
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
