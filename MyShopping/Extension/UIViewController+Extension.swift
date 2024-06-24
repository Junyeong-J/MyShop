//
//  UIViewController+Extension.swift
//  MyShopping
//
//  Created by 전준영 on 6/24/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, ok: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ok, style: .default) { _ in
            completionHandler()
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}
