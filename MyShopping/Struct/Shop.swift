//
//  Struct.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import Foundation

struct Shop: Decodable {
    let total: Int
    let start: Int
    let display: Int
    var items: [ShopItems]
    
    var totalDescription: String {
        return "\(total.formatted())개의 검색 결과"
    }
    
    
}

struct ShopItems: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
    
    var formatPrice: String {
        if let price = Int(lprice){
            return "\(price.formatted())원"
        } else {
            return "0원"
        }
    }
    
    var setTitle: String {
        return title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    }
}
