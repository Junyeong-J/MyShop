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
    
    let profileForKey = "profileName"
    let nicknameForKey = "nickname"
    let searchHistoryForKey = "searchHistory"
    let user = "isUser"
    //MARK: - 프로필
    var profileName: String? {
        get {
            guard let profileName = UserDefaults.standard.string(forKey: profileForKey) else {
                return nil
            }
            return profileName
        }
        set {
            UserDefaults.standard.set(newValue, forKey: profileForKey)
        }
    }
    //MARK: - 닉네임
    var nickname: String? {
        get {
            guard let nickname = UserDefaults.standard.string(forKey: nicknameForKey) else {
                return nil
            }
            return nickname
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nicknameForKey)
        }
    }
    
    //MARK: - 사용자
    func isUser() {
        UserDefaults.standard.set(true, forKey: user)
    }
    
    //MARK: - 최근 검색어
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
