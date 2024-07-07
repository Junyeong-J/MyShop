//
//  LikeListViewController.swift
//  MyShopping
//
//  Created by 전준영 on 7/7/24.
//

import UIKit
import SnapKit
import RealmSwift

class LikeListViewController: BaseViewController {
    
    let likeTableView = UITableView()
    let searchBar = UISearchBar()
    
    var list: Results<LikeListTable>!
    let repository = LikeListTableRepository()
    let ud = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI()
        configureTableView()
        configureSearchBar()
        
        list = repository.fetchAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        likeTableView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(likeTableView)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        likeTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension LikeListViewController {
    
    func makeNavigationUI() {
        navigationItem.title = ViewType.like.rawValue
    }
    
    func configureTableView() {
        likeTableView.dataSource = self
        likeTableView.delegate = self
        likeTableView.rowHeight = 100
        likeTableView.register(LikeListTableViewCell.self, forCellReuseIdentifier: LikeListTableViewCell.identifier)
    }
    
    func configureSearchBar() {
        searchBar.placeholder = "좋아요 목록 검색"
        searchBar.delegate = self
    }
    
}

extension LikeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LikeListTableViewCell.identifier, for: indexPath) as! LikeListTableViewCell
        cell.configureData(data: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "좋아요 삭제") { (action, view, completionHandler) in
            let productId = self.list[indexPath.row]
            if self.ud.likeId.contains(productId.productId) {
                self.ud.removeLikeId(id: productId.productId)
                self.repository.deleteIdItem(productId)
            }
            self.likeTableView.reloadData()
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailWebViewController()
        let data = list[indexPath.row]
        vc.data = ShopItems(title: data.productTitle, link: data.link, image: data.image, lprice: data.price, mallName: data.mallName, productId: data.productId)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LikeListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        list = repository.searchItem(searchText)
        likeTableView.reloadData()
    }
}
