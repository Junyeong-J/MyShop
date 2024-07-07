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
    
    let repository = LikeListTableRepository()
    let ud = UserDefaultsManager.shared
    var data = ShopItems(title: "", link: "", image: "", lprice: "", mallName: "", productId: "")
    
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
        let likeImage = data.isliked == true ? "like_selected" : "like_unselected"
        let likeButton = UIBarButtonItem(image: UIImage(named: likeImage)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(likeButtonClicked))
        navigationItem.rightBarButtonItem = likeButton
        navigationController?.navigationBar.tintColor = Color.black
        navigationItem.title = data.setTitle
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
        view.backgroundColor = Color.white
    }
    
    func configureWebView() {
        let url = URL(string: data.link)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func likeButtonClicked() {
        let data = LikeListTable(productId: data.productId, productTitle: data.setTitle, mallName: data.mallName, price: data.formatPrice, image: data.image, link: data.link, regdate: Date())
        
        if ud.likeId.contains(data.productId) {
            ud.removeLikeId(id: data.productId)
            repository.deleteIdItem(data)
        } else {
            ud.saveLikeId(id: data.productId)
            repository.createItem(data)
        }
        let isLiked = ud.likeId.contains(data.productId)
        likeButtonUI(isLiked: isLiked)
    }
    
    func likeButtonUI(isLiked: Bool) {
        let likeImage = isLiked ? "like_selected" : "like_unselected"
        let likeButton = UIBarButtonItem(image: UIImage(named: likeImage)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(likeButtonClicked))
        navigationItem.rightBarButtonItem = likeButton
    }
}
