//
//  SearchViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/14/24.
//

import UIKit
import SnapKit
import Toast

class SearchViewController: UIViewController {
    
    let deviceWidth = UIScreen.main.bounds.size.width
    
    let emptyImageView = EmptyImage(title: "empty")
    let emptyLabel = SetLabel(title: "최근 검색어가 없어요", textAlignment: .center, color: Color.black, backgroundColor: .clear, font: Font.bold17, cornerRadius: 0, numberLine: 1)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleSet()
    }
    
}

extension SearchViewController {
    
    func makeNavigationUI() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .black
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = TextFieldPlaceholder.search.rawValue
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        titleSet()
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
    
    func titleSet() {
        guard let nickname = ud.nickname else {
            self.view.makeToast("닉네임이 잘못 입력되었습니다.")
            return
        }
        navigationItem.title = "\(nickname)님의 MEANING OUT"
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            self.view.makeToast("검색어가 잘못 입력되었습니다.")
            return
        }
        
        do {
            let result = try validateUserInput(text: searchText)
            print(result)
        } catch ValidationError.emptyString {
            self.view.makeToast("검색어를 입력하세요")
            return
        } catch ValidationError.trimmingCharacters {
            self.view.makeToast("공백만 검색이 안됩니다")
            return
        } catch {
            self.view.makeToast("검색어 문제입니다.")
            return
        }
        
        ud.saveSearchWord(word: searchText)
        tableView.reloadData()
        screenLayout()
        
        let vc = SearchResultViewController()
        vc.navigationTitle = searchText
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func validateUserInput(text: String) throws -> Bool {
        guard !(text.isEmpty) else {
            throw ValidationError.emptyString
        }
        
        guard !isOnlyWhitespace(text: text) else {
            throw ValidationError.trimmingCharacters
        }
        
        return true
    }
    
    func isOnlyWhitespace(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchWord = ud.recentWord
        let word = searchWord[indexPath.row]
        let vc = SearchResultViewController()
        vc.navigationTitle = word
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
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
