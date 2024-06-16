//
//  Setting.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit

enum SettingOption: String, CaseIterable {
    case myList = "나의 장바구니 목록"
    case quset = "자주 묻는 질문"
    case inquiry = "1:1문의"
    case notification = "알림 설정"
    case withdraw = "탈퇴하기"
    
//    func addTargets() {
//        switch self {
//        case .myList:
//            print("1")
//        case .quset:
//            print("2")
//        case .inquiry:
//            print("3")
//        case .notification:
//            print("4")
//        case .withdraw:
//            let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", preferredStyle: .alert)
//            
//            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
//            
//            present(alert, animated: true)
//        }
//    }
}
