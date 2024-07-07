//
//  LikeRealmModel.swift
//  MyShopping
//
//  Created by 전준영 on 7/7/24.
//

import Foundation
import RealmSwift

class LikeListTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var productId: String
    @Persisted var productTitle: String
    @Persisted var mallName: String
    @Persisted var price: String
    @Persisted var favorite: Bool
    @Persisted var regdate: Date
    
    convenience init(productId: String, productTitle: String, mallName: String, price: String, regdate: Date) {
        self.init()
        self.productId = productId
        self.productTitle = productTitle
        self.mallName = mallName
        self.price = price
        self.favorite = false
        self.regdate = regdate
    }
    
    override static func primaryKey() -> String? {
        return "productId"
    }
}
