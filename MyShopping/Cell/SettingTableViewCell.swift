//
//  SettingTableViewCell.swift
//  MyShopping
//
//  Created by 전준영 on 6/16/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    let ud = UserDefaultsManager.shared
    
    let listLabel = UILabel()
    let bagImage = BagImage()
    let countLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(listLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(bagImage)
    }
    
    func configureLayout() {
        listLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).inset(16)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(16)
        }
        
        bagImage.snp.makeConstraints { make in
            make.trailing.equalTo(countLabel.snp.leading).offset(3)
            make.centerY.equalTo(contentView)
            make.size.equalTo(20)
        }
    }
    
    func configureUI() {
        listLabel.setUILabel("", textAlignment: .left, color: Color.black, backgroundColor: .clear, font: Font.regular15, cornerRadius: 0, numberLine: 1)
        countLabel.setUILabel("", textAlignment: .right, color: Color.black, backgroundColor: .clear, font: Font.bold15, cornerRadius: 0, numberLine: 1)
    }
    
    func configureData(data: String, indexPath: IndexPath) {
        listLabel.text = data
        if indexPath.row == 0 {
            countLabel.isHidden = false
            bagImage.isHidden = false
            countLabel.text = "\(ud.likeId.count)개의 상품"
            attributeSetString()
        } else {
            countLabel.isHidden = true
            bagImage.isHidden = true
        }
    }
    
    func attributeSetString() {
        let attributeString = NSMutableAttributedString(string: countLabel.text!)
        let font = UIFont.systemFont(ofSize: 15)
        attributeString.addAttribute(.font, value: font, range: (countLabel.text! as NSString).range(of: "개의 상품"))
        self.countLabel.attributedText = attributeString
    }
    
}
