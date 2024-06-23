//
//  SearchResultViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit
import SnapKit
import SkeletonView

class SearchResultViewController: UIViewController {
    
    var list = Shop(total: 0, start: 0, display: 0, items: [])
    var start = 1
    var sort: Sort = .accuracy
    let ud = UserDefaultsManager.shared
    
    var navigationTitle: String = ""
    let categoryView = UIView()
    var countLabel = UILabel()
    let stackView = UIStackView()
    let accuracyButton = CategoryButton(title: Sort.accuracy.rawValue)
    let dateButton = CategoryButton(title: Sort.date.rawValue)
    let highPriceButton = CategoryButton(title: Sort.highPrice.rawValue)
    let lowPriceButton = CategoryButton(title: Sort.lowPrice.rawValue)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 50
        layout.itemSize = CGSize(width: width/2, height: (width/2)*1.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 10, right: 20)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        configureCollectionView()
        callRequest(query: navigationTitle, sort: sort.sortTargets())
        
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
}

extension SearchResultViewController {
    
    func makeNavigationUI() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = Color.black
        navigationItem.title = navigationTitle
    }
    
    func configureHierarchy() {
        view.addSubview(categoryView)
        categoryView.addSubview(countLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(accuracyButton)
        stackView.addArrangedSubview(dateButton)
        stackView.addArrangedSubview(highPriceButton)
        stackView.addArrangedSubview(lowPriceButton)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        categoryView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryView).inset(20)
            make.top.equalTo(categoryView).inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(categoryView).inset(20)
            make.top.equalTo(countLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(categoryView.snp.bottom)
        }
        
    }
    
    func configureUI() {
        view.backgroundColor = Color.white
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        countLabel.setUILabel("", textAlignment: .left, color: Color.myShopMainColor, backgroundColor: .clear, font: Font.bold13, cornerRadius: 0, numberLine: 1)
        
        accuracyButton.backgroundColor = Color.buttonBackground
        accuracyButton.setTitleColor(Color.white, for: .normal)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    func addTargets() {
        accuracyButton.addTarget(self, action: #selector(sortButtonClikced), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(sortButtonClikced), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(sortButtonClikced), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(sortButtonClikced), for: .touchUpInside)
    }
    
    func callRequest(query: String, sort: String) {
        DispatchQueue.global().async{
            NaverShopManager.shared.getNaverShop(query: query, sort: sort, start: self.start) { result in
                DispatchQueue.main.async{
                    switch result {
                    case .success(let value):
                        self.countLabel.text = value.totalDescription
                        if self.start == 1{
                            self.list = value
                        } else {
                            self.list.items.append(contentsOf: value.items)
                        }
                        self.collectionView.reloadData()
                        
                        if self.start == 1 && !self.list.items.isEmpty {
                            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                        }
                    case .failure(_):
                        self.view.makeToast("네트워크 에러입니다. 잠시후 다시 사용해 주세요.")
                    }
                }
            }
        }
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sortButtonClikced(_ sender: CategoryButton) {
        
        let sortButtonList = [accuracyButton, dateButton, highPriceButton, lowPriceButton]
        
        for sortbutton in sortButtonList {
            sortbutton.backgroundColor = Color.white
            sortbutton.setTitleColor(Color.black, for: .normal)
        }
        
        sender.backgroundColor = Color.buttonBackground
        sender.setTitleColor(Color.white, for: .normal)
        switch sender {
        case accuracyButton:
            sort = .accuracy
        case dateButton:
            sort = .date
        case highPriceButton:
            sort = .highPrice
        case lowPriceButton:
            sort = .lowPrice
        default:
            return
        }
        start = 1
        callRequest(query: navigationTitle, sort: sort.sortTargets())
    }
    
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        cell.id = list.items[indexPath.item].productId
        cell.configureData(data: list.items[indexPath.item], indexPath: indexPath, highLight: navigationTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailWebViewController()
        vc.data = list.items[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if list.items.count - 6 == item.item && list.start < list.total{
                start += 30
                callRequest(query: navigationTitle, sort: sort.sortTargets())
            }
        }
    }
}
