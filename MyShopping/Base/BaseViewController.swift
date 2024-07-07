//
//  BaseViewController.swift
//  MyShopping
//
//  Created by 전준영 on 7/7/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
    }
     
    func configureHierarchy() {
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureConstraints() {
        
    }
    
    //재정의 가능성이 있다. 어떤메서드가 실행될지는 컴파일
    func showAlert(title: String,message: String, ok: String, handler: @escaping (() -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            handler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
     
}
