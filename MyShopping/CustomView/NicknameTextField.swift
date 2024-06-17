//
//  NicknameTextField.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit

class NicknameTextField: UITextField {
    
    init(style: TextFieldPlaceholder) {
        super.init(frame: .zero)
        
        placeholder = style.rawValue
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
