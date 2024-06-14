//
//  ProfileCollectionViewCell.swift
//  MyShopping
//
//  Created by 전준영 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    var contentViewWidth: CGFloat {
        return contentView.bounds.width
    }
    
    lazy var imageView = ProfileImage(profile: "profile_1", corner: contentViewWidth / 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy(){
        contentView.addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.size.equalTo(contentView.snp.width)
        }
    }
    
    func configureUI() {
        
    }
    
    func configureData(imageNames: String) {
        imageView.image = UIImage(named: imageNames)
        imageView.alpha = 0.5
        imageView.layer.borderWidth = 1
    }
    
    func configureEqualData(imageNames: String) {
        imageView.image = UIImage(named: imageNames)
        imageView.alpha = 1
        imageView.layer.borderWidth = 2
    }
    
}
