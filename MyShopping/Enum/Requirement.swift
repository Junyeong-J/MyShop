//
//  Requirement.swift
//  MyShopping
//
//  Created by 전준영 on 6/17/24.
//

import UIKit

enum Requirement: String {
    case number = "닉네임에 숫자는 포함할 수 없어요"
    case at = "닉네임에 @는 포함할 수 없어요"
    case hash = "닉네임에 #는 포함할 수 없어요"
    case dollar = "닉네임에 $는 포함할 수 없어요"
    case percent = "닉네임에 %는 포함할 수 없어요"
    case count = "2글자 이상 10글자 미만으로 설정해주세요"
    case correct = "사용할 수 있는 닉네임이에요"
}
