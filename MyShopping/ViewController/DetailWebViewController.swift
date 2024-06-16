//
//  DetailWebViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit
import WebKit
import SnapKit

class DetailWebViewController: UIViewController {
    
    let webView = WKWebView()
    var navigationTitle = ""
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeNavigationUI()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        configureWebView()
    }

}

extension DetailWebViewController {
    
    func makeNavigationUI() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        let likeButton = UIBarButtonItem(image: UIImage(systemName: "bag.fill"), style: .plain, target: self, action: #selector(likeButtonClicked))
        navigationItem.rightBarButtonItem = likeButton
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = navigationTitle
    }
    
    func configureHierarchy() {
        view.addSubview(webView)
    }
    
    func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureWebView() {
        let url = URL(string: link)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func likeButtonClicked() {
        
    }
}
