//
//  Requirement.swift
//  MyShopping
//
//  Created by 전준영 on 6/17/24.
//

import UIKit

enum NicknameError: Error {
    case number
    case at
    case hash
    case dollar
    case percent
    case count
    case correct
    
    var eachError: String{
        switch self {
        case .number:
            return "닉네임에 숫자는 포함할 수 없어요"
        case .at:
            return "닉네임에 @는 포함할 수 없어요"
        case .hash:
            return "닉네임에 #는 포함할 수 없어요"
        case .dollar:
            return "닉네임에 $는 포함할 수 없어요"
        case .percent:
            return "닉네임에 %는 포함할 수 없어요"
        case .count:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .correct:
            return "사용할 수 있는 닉네임이에요"
        }
    }
}
