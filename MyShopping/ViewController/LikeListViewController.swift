//
//  LikeListViewController.swift
//  MyShopping
//
//  Created by 전준영 on 7/7/24.
//

import UIKit
import SnapKit

class LikeListViewController: BaseViewController {
    
    let likeTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI()
        configureTableView()
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
        likeTableView.register(LikeListTableViewCell.self, forCellReuseIdentifier: LikeListTableViewCell.identifier)
    }
    
}

extension LikeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LikeListTableViewCell.identifier, for: indexPath) as! LikeListTableViewCell
        return cell
    }
}
