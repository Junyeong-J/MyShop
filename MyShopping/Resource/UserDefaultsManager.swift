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
    let date = "joinDate"
    let searchHistoryForKey = "searchHistory"
    let user = "isUser"
    let like = "likePorduct"
    
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
    
    //MARK: - 회원가입 날짜
    var joinDate: String? {
        get {
            guard let nowDate = UserDefaults.standard.string(forKey: date) else {
                return nil
            }
            return nowDate
        }
        set {
            UserDefaults.standard.set(newValue, forKey: date)
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
    
    //MARK: - 좋아요 기능
    var likeId: [String] {
        
        get {
            return UserDefaults.standard.array(forKey: like) as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: like)
        }
        
    }
    
    func saveLikeId(id: String) {
        var productId = likeId
        if let existingIndex = productId.firstIndex(of: id) {
            productId.remove(at: existingIndex)
        }
        productId.insert(id, at: 0)
        likeId = productId
    }
    
    func removeLikeId(id: String) {
        var productId = likeId
        if let existingIndex = productId.firstIndex(of: id) {
            productId.remove(at: existingIndex)
        }
        likeId = productId
    }
    
    //MARK: - 모두 삭제(탈퇴)
    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: profileForKey)
        UserDefaults.standard.removeObject(forKey: nicknameForKey)
        UserDefaults.standard.removeObject(forKey: date)
        UserDefaults.standard.removeObject(forKey: searchHistoryForKey)
        UserDefaults.standard.removeObject(forKey: like)
        UserDefaults.standard.removeObject(forKey: user)
    }
    
}
