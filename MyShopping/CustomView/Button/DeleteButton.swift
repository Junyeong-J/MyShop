//
//  DeleteButton.swift
//  MyShopping
//
//  Created by 전준영 on 6/15/24.
//

import UIKit

class DeleteButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setImage(UIImage(systemName: "xmark"), for: .normal)
        tintColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
