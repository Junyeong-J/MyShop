//
//  SettingViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/14/24.
//

import UIKit
import SnapKit
import Toast

class SettingViewController: UIViewController {
    
    let ud = UserDefaultsManager.shared
    let repository = LikeListTableRepository()
    
    let tableView = UITableView()
    let headerView = UIView()
    let imageView = ProfileImage(profile: "profile_1", corner: 30, border: 3)
    let buttonImageView = ChevronImage()
    let nickName = UILabel()
    let dateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationUI()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        setUI()
        tapGesture()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let nickname = ud.nickname, let imagename = ud.profileName else {
            return }
        nickName.text = nickname
        imageView.image = UIImage(named: imagename)
        tableView.reloadData()
    }
}

extension SettingViewController {
    
    func makeNavigationUI() {
        navigationItem.title = ViewType.set.rawValue
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
        view.backgroundColor = Color.white
        
        headerView.backgroundColor = Color.white
        
        nickName.setUILabel("", textAlignment: .left, color: Color.black, backgroundColor: .clear, font: Font.bold17, cornerRadius: 0, numberLine: 1)
        
        dateLabel.setUILabel("", textAlignment: .left, color: Color.gray, backgroundColor: .clear, font: Font.regular13, cornerRadius: 0, numberLine: 1)
        
    }
    
    func configureTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = Color.black
        tableView.rowHeight = 55
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewClicked))
        headerView.addGestureRecognizer(tapGesture)
        headerView.isUserInteractionEnabled = true
    }
    
    func setUI() {
        guard let nickname = ud.nickname, let imagename = ud.profileName, let date = ud.joinDate else { return }
        nickName.text = nickname
        imageView.image = UIImage(named: imagename)
        dateLabel.text = date
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
        cell.configureData(data: SettingOption.allCases[indexPath.row].rawValue, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        switch indexPath.row {
        case 0: toastMessage(message: "준비중 입니다.")
        case 1: toastMessage(message: "준비중 입니다.")
        case 2: toastMessage(message: "준비중 입니다.")
        case 3: toastMessage(message: "준비중 입니다.")
        case 4: 
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.", ok: "확인") {
                self.ud.clearAllData()
                self.repository.deleteAll()
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let rootViewController = UINavigationController(rootViewController: OnBoardingViewController())
                sceneDelegate?.window?.rootViewController = rootViewController
                sceneDelegate?.window?.makeKeyAndVisible()
            }
        default:
            toastMessage(message: "앱을 끄고 다시 실행해 주세요.")
        }
    }
    
    func toastMessage(message: String) {
        self.view.makeToast(message)
    }
}
