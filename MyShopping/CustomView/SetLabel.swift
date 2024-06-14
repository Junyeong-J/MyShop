//
//  SetLabel.swift
//  MyShopping
//
//  Created by 전준영 on 6/13/24.
//

import UIKit

class SetLabel: UILabel {
    
    init(title: String, textAlignment: NSTextAlignment, color: UIColor, backgroundColor: UIColor, font: UIFont, cornerRadius: Double, numberLine: Int){
        super.init(frame: .zero)
        
        setUILabel(title, textAlignment: textAlignment, color: color, backgroundColor: backgroundColor, font: font, cornerRadius: cornerRadius, numberLine: numberLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
