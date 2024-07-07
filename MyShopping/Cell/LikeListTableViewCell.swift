//
//  LikeListTableViewCell.swift
//  MyShopping
//
//  Created by 전준영 on 7/7/24.
//

import UIKit
import SnapKit
import Kingfisher

class LikeListTableViewCell: BaseTableViewCell {
    
    let productImageView = ProductImage()
    let buttonImageView = ChevronImage()
    let titleLabel = UILabel()
    let mallNameLabel = UILabel()
    let priceLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(buttonImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(priceLabel)
    }
    
    override func configureLayout() {
        productImageView.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        buttonImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(20)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(20)
            make.trailing.equalTo(buttonImageView.snp.leading).offset(20)
            make.top.equalTo(productImageView).inset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(20)
            make.trailing.equalTo(buttonImageView.snp.leading).offset(-10)
            make.top.equalTo(mallNameLabel.snp.bottom).offset(3)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(20)
            make.trailing.equalTo(buttonImageView.snp.leading).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        
    }
    
    override func configureView() {
        mallNameLabel.setUILabel("", textAlignment: .left, color: Color.lightGray, backgroundColor: .clear, font: Font.regular13, cornerRadius: 0, numberLine: 1)
        titleLabel.setUILabel("", textAlignment: .left, color: Color.black, backgroundColor: .clear, font: Font.regular14, cornerRadius: 0, numberLine: 2)
        priceLabel.setUILabel("", textAlignment: .left, color: Color.black, backgroundColor: .clear, font: Font.bold16, cornerRadius: 0, numberLine: 1)
    }
    
    func configureData(data: LikeListTable){
        let imageUrl = URL(string: data.image)
        productImageView.kf.setImage(with: imageUrl)
        mallNameLabel.text = data.mallName
        titleLabel.text = data.productTitle
        priceLabel.text = data.price
    }
    
}
