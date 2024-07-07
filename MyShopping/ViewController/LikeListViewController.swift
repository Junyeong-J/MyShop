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
    var list: Results<LikeListTable>!
    let repository = LikeListTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI()
        configureTableView()
        
        list = repository.fetchAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        likeTableView.reloadData()
    }
    
    override func configureHierarchy() {
        view.addSubview(likeTableView)
    }
    
    override func configureConstraints() {
        likeTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
}
