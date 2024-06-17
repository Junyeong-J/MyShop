//
//  SearchResultCollectionViewCell.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit
import Kingfisher
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    let width = UIScreen.main.bounds.width
    let productImageView = ProductImage()
    let mallNameLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let likeButton = LikeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  configureHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        productImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView).inset(2)
            make.height.equalTo((((width - 50) / 2) * 1.5) * 0.7)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(productImageView).inset(10)
            make.size.equalTo(30)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(productImageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(productImageView)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(productImageView)
        }
        
    }
    
    func configureUI() {
        
        mallNameLabel.setUILabel("", textAlignment: .left, color: Color.lightGray, backgroundColor: .clear, font: Font.regular13, cornerRadius: 0, numberLine: 1)
        
        titleLabel.setUILabel("", textAlignment: .left, color: .black, backgroundColor: .clear, font: Font.regular14, cornerRadius: 0, numberLine: 2)
        
        priceLabel.setUILabel("", textAlignment: .left, color: .black, backgroundColor: .clear, font: Font.bold17, cornerRadius: 0, numberLine: 1)
    }
    
    func configureData(data: ShopItems) {
        
        let imageUrl = URL(string: data.image)
        productImageView.kf.setImage(with: imageUrl)
        mallNameLabel.text = data.mallName
        titleLabel.text = data.setTitle
        priceLabel.text = data.formatPrice
    }
}
