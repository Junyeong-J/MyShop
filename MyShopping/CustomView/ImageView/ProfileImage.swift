//
//  ProfileImage.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit

class ProfileImage: UIImageView {
    init(profile: String, corner: Double) {
        super.init(frame: .zero)
        
        image = UIImage(named: profile)
        contentMode = .scaleAspectFill
        layer.cornerRadius = corner
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 0.9564719796, green: 0.610019803, blue: 0.3464771509, alpha: 1)
        clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
