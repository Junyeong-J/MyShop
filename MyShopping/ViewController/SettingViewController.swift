//
//  SettingViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/14/24.
//

import UIKit
import SnapKit



class SettingViewController: UIViewController {
    
    let ud = UserDefaultsManager.shared
    
    let tableView = UITableView()
    let headerView = UIView()
    let imageView = ProfileImage(profile: "profile_1", corner: 30)
    let buttonImageView = ChevronImage()
    let nickName = UILabel()
    let dateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationUI()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        tapGesture()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let nickname = ud.nickname, let imagename = ud.profileName else { return }
        nickName.text = nickname
        imageView.image = UIImage(named: imagename)
    }
}

extension SettingViewController {
    
    func makeNavigationUI() {
        navigationItem.title = "SETTING"
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(headerView)
        headerView.addSubview(imageView)
        headerView.addSubview(buttonImageView)
        headerView.addSubview(nickName)
        headerView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        
        headerView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(headerView)
            make.size.equalTo(60)
            make.leading.equalTo(headerView).inset(16)
        }
        
        buttonImageView.snp.makeConstraints { make in
            make.centerY.equalTo(headerView)
            make.size.equalTo(20)
            make.trailing.equalTo(headerView).inset(16)
        }
        
        nickName.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalTo(buttonImageView.snp.leading).offset(20)
            make.bottom.equalTo(headerView.snp.centerY).offset(1)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalTo(buttonImageView.snp.leading).offset(20)
            make.top.equalTo(headerView.snp.centerY).offset(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(headerView.snp.bottom)
        }
        
    }
    
    func configureUI(){
        view.backgroundColor = .white
        headerView.backgroundColor = .white
        dateLabel.text = "aaaa"
    }
    
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .black
        tableView.rowHeight = 44
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewClicked))
        headerView.addGestureRecognizer(tapGesture)
        headerView.isUserInteractionEnabled = true
    }
    
    @objc func headerViewClicked() {
        let nv = NicknameViewController()
        nv.viewtype = .old
        navigationController?.pushViewController(nv, animated: true)
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        cell.textLabel?.text = SettingOption.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0: print("")
        case 1: print("")
        case 2: print("")
        case 3: print("")
        case 4: let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                self.ud.clearAllData()
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let rootViewController = UINavigationController(rootViewController: OnBoardingViewController())
                sceneDelegate?.window?.rootViewController = rootViewController
                sceneDelegate?.window?.makeKeyAndVisible()
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        default:
            print("ERROR")
        }
        
        
    }
}
