//
//  Sort.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit

enum Sort: String, CaseIterable {
    case accuracy = "정확도"
    case date = "날짜순"
    case highPrice = "가격높은순"
    case lowPrice = "가격낮은순"
    
    func sortTargets() -> String {
        switch self {
        case .accuracy:
            return "sim"
        case .date:
            return "date"
        case .highPrice:
            return "dsc"
        case .lowPrice:
            return "asc"
        }
    }
}
