//
//  LikeListTableRepository.swift
//  MyShopping
//
//  Created by 전준영 on 7/7/24.
//

import Foundation
import RealmSwift

final class LikeListTableRepository {
    
    private let realm = try! Realm()
    
    func createItem(_ data: LikeListTable) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
        
    }
    
    func deleteIdItem(_ item: LikeListTable) {
        if let objectToDelete = realm.object(ofType: LikeListTable.self, forPrimaryKey: item.productId) {
            try! realm.write {
                realm.delete(objectToDelete)
            }
        }
    }
    
    func fetchAll() -> Results<LikeListTable> {
        return realm.objects(LikeListTable.self).sorted(byKeyPath: "regdate", ascending: false)
    }
    
    func deleteAll() {
        let allItems = realm.objects(LikeListTable.self)
        do {
            try realm.write {
                realm.delete(allItems)
            }
        } catch {
            print("Realm Error")
        }
    }
    
    func searchItem(_ text: String) -> Results<LikeListTable> {
        if text.isEmpty {
            return fetchAll()
        } else {
            return realm.objects(LikeListTable.self).where {
                $0.productTitle.contains(text, options: .caseInsensitive)
            }
        }
    }
    
}
