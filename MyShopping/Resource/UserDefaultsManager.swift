//
//  UserDefaultsManager.swift
//  MyShopping
//
//  Created by 전준영 on 6/15/24.
//

import UIKit

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    let searchHistoryForKey = "searchHistory"
    
    var recentWord: [String] {
        
        get {
            return UserDefaults.standard.array(forKey: searchHistoryForKey) as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: searchHistoryForKey)
        }
        
    }
    
    func saveSearchWord(word: String) {
        var history = recentWord
        if let existingIndex = history.firstIndex(of: word) {
            history.remove(at: existingIndex)
        }
        history.insert(word, at: 0)
        recentWord = history
    }
    
    func clearSearchHistory() {
        UserDefaults.standard.removeObject(forKey: searchHistoryForKey)
    }
    
}
