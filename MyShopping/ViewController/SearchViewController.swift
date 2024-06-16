//
//  SearchViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/14/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {

    let deviceWidth = UIScreen.main.bounds.size.width
    
    let emptyImageView = EmptyImage(title: "empty")
    let emptyLabel = SetLabel(title: "최근 검색어가 없어요", textAlignment: .center, color: .black, backgroundColor: .clear, font: Font.bold17, cornerRadius: 0, numberLine: 1)
    let tableView = UITableView()
    
    let ud = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationUI()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        configureTableView()
        screenLayout()
    }

}

extension SearchViewController {
    
    func makeNavigationUI() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = TextFieldPlaceholder.search.rawValue
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.title = "000님의 MEANING OUT"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureHierarchy() {
        view.addSubview(emptyImageView)
        view.addSubview(emptyLabel)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        emptyImageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(deviceWidth - 60)
            make.height.equalTo((deviceWidth - 60) * 0.8)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(emptyImageView.snp.bottom).offset(2)
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
    func configureUI() {
        view.backgroundColor = Color.white
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    func screenLayout() {
        if ud.recentWord.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        ud.saveSearchWord(word: searchText)
        tableView.reloadData()
        screenLayout()
        
        let vc = SearchResultViewController()
        vc.navigationTitle = searchText
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ud.recentWord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.configureData(word: ud.recentWord[indexPath.row])
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteBUttonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = Color.white
        let titleLabel = UILabel()
        titleLabel.text = "최근 검색"
        titleLabel.font = Font.bold17
        
        let allClearButton = UIButton(type: .system)
        allClearButton.setTitle("전체 삭제", for: .normal)
        allClearButton.setTitleColor(Color.myShopMainColor, for: .normal)
        allClearButton.addTarget(self, action: #selector(allClearButtonClicked), for: .touchUpInside)
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(allClearButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerView.snp.leading).offset(16)
            make.centerY.equalTo(headerView)
        }
        
        allClearButton.snp.makeConstraints { make in
            make.trailing.equalTo(headerView.snp.trailing).offset(-16)
            make.centerY.equalTo(headerView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    @objc func allClearButtonClicked() {
        ud.clearSearchHistory()
        self.tableView.reloadData()
        screenLayout()
    }
    
    @objc func deleteBUttonClicked(_ sender: UIButton) {
        var word = ud.recentWord
        word.remove(at: sender.tag)
        ud.recentWord = word
        self.tableView.reloadData()
        screenLayout()
    }
}
