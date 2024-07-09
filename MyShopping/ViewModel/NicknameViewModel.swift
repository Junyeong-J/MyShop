//
//  NicknameViewModel.swift
//  MyShopping
//
//  Created by 전준영 on 7/10/24.
//

import Foundation

class NicknameViewModel {
    
    var inputNickname: Observable<String?> = Observable(nil)
    
    var outputValidationText = Observable("")
    var outputValid = Observable(false)
    
    init() {
        inputNickname.bind { nickname in
            self.validateNickname(nickname)
        }
    }
    
    private func validateNickname(_ nickname: String?) {
        guard let text = nickname else {
            outputValidationText.value = "텍스트 필드에 잘못 입력되었습니다."
            outputValid.value = false
            return
        }
        
        do {
            try requestNickname(text: text)
            outputValidationText.value = NicknameError.correct.eachError
            outputValid.value = true
        } catch let error as NicknameError {
            outputValidationText.value = error.eachError
            outputValid.value = false
        } catch {
            outputValidationText.value = "텍스트 필드에 잘못 입력되었습니다."
            outputValid.value = false
        }
    }
    
    private func requestNickname(text: String) throws {
        if !textLength(text: text) {
            throw NicknameError.count
        }
        
        if text.range(of: "\\d", options: .regularExpression) != nil {
            throw NicknameError.number
        }
        
        if text.contains("@") {
            throw NicknameError.at
        }
        
        if text.contains("#") {
            throw NicknameError.hash
        }
        
        if text.contains("$") {
            throw NicknameError.dollar
        }
        
        if text.contains("%") {
            throw NicknameError.percent
        }
    }
    
    private func textLength(text: String) -> Bool {
        return text.count >= 2 && text.count < 10
    }
}
