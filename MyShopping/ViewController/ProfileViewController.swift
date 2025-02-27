//
//  ProfileViewController.swift
//  MyShopping
//
//  Created by 전준영 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    weak var delegate: ProfileProtocol?
    var imageName = ""
    var viewtype: ViewType = .new
    
    let cameraImage = CameraImage()
    lazy var profileImageView = ProfileImage(profile: imageName, corner: 50, border: 3)
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/4, height: width/4 * 1.3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        configureCollectionView()
    }

}

extension ProfileViewController {
    
    func makeNavigationUI() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.title = viewtype.rawValue
    }
    
    func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(cameraImage)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
            make.size.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
    }
    
    func configureUI() {
        view.backgroundColor = Color.white
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        
    }
    
    @objc func backButtonClicked() {
        delegate?.selectImageName(imageName: imageName)
        navigationController?.popViewController(animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as! ProfileCollectionViewCell
        let profileName = "profile_\(indexPath.item)"
        if imageName == profileName {
            cell.configureEqualData(imageNames: profileName)
        } else {
            cell.configureData(imageNames: profileName)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageName = "profile_\(indexPath.item)"
        profileImageView.image = UIImage(named: imageName)
        collectionView.reloadData()
    }
    
}
