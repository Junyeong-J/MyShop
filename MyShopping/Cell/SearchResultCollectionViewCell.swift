//
//  SearchResultCollectionViewCell.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit
import Kingfisher
import SnapKit
import SkeletonView
import RealmSwift

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    var list: Results<LikeListTable>!
    let repository = LikeListTableRepository()
    
    var itemsData = ShopItems(title: "", link: "", image: "", lprice: "", mallName: "", productId: "")
    let width = UIScreen.main.bounds.width
    let ud = UserDefaultsManager.shared
    var id: String?
    
    let productImageView = ProductImage()
    let mallNameLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    var likeButton = LikeButton(backColor: Color.blackAlpha50, tint: Color.white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
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
        
        titleLabel.setUILabel("", textAlignment: .left, color: Color.black, backgroundColor: .clear, font: Font.regular14, cornerRadius: 0, numberLine: 2)
        
        priceLabel.setUILabel("", textAlignment: .left, color: Color.black, backgroundColor: .clear, font: Font.bold16, cornerRadius: 0, numberLine: 1)
    }
    
    func configureData(data: ShopItems, indexPath: IndexPath, highLight: String) {
        skeletonViewStart()
        self.itemsData = data
        let imageUrl = URL(string: data.image)
        productImageView.kf.setImage(with: imageUrl)
        mallNameLabel.text = data.mallName
        titleLabel.text = data.setTitle
        priceLabel.text = data.formatPrice
        likeButton.tag = indexPath.row
        likeButtonUI(isLiked: data.isliked)
        attributeSetString(titleLabel, changeString: highLight)
        skeletonViewFinish()
    }
    
    func likeButtonUI(isLiked: Bool) {
        if isLiked {
            likeButton.backgroundColor = Color.white
            likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
            likeButton.tintColor = Color.black
        } else {
            likeButton.backgroundColor = Color.blackAlpha50
            likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
            likeButton.tintColor = Color.white
        }
    }
    
    func skeletonViewStart() {
        contentView.isSkeletonable = true
        contentView.showAnimatedGradientSkeleton()
    }
    
    func skeletonViewFinish() {
        contentView.hideSkeleton()
    }
    
    @objc func likeButtonClicked() {
        guard let productId = id else { return }
        let data = LikeListTable(productId: productId, productTitle: itemsData.setTitle, mallName: itemsData.mallName, price: itemsData.formatPrice, image: itemsData.image, link: itemsData.link, regdate: Date())
        
        if ud.likeId.contains(productId) {
            ud.removeLikeId(id: productId)
            repository.deleteIdItem(data)
        } else {
            ud.saveLikeId(id: productId)
            repository.createItem(data)
        }
        
        let isLiked = ud.likeId.contains(productId)
        likeButtonUI(isLiked: isLiked)
    }
    
    func attributeSetString(_ label: UILabel, changeString: String) {
        let attributeString = NSMutableAttributedString(string: label.text!)
        let font = UIFont.systemFont(ofSize: 14, weight: .black)
        attributeString.addAttribute(.font, value: font, range: (label.text! as NSString).range(of: changeString))
        label.attributedText = attributeString
    }
    
}
