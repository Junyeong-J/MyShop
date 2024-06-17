//
//  SearchTableViewCell.swift
//  MyShopping
//
//  Created by 전준영 on 6/15/24.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {

    let recentImageView = RecentImage()
    let deleteButton = DeleteButton()
    let searchWordLabel = UILabel()
    
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
        contentView.addSubview(recentImageView)
        contentView.addSubview(deleteButton)
        contentView.addSubview(searchWordLabel)
        
    }
    
    func configureLayout() {
        recentImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).inset(16)
            make.size.equalTo(20)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(16)
            make.size.equalTo(25)
        }
        
        searchWordLabel.snp.makeConstraints { make in
            make.leading.equalTo(recentImageView.snp.trailing).offset(10)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
            make.centerY.equalTo(contentView)
        }
        
    }
    
    func configureUI() {
        searchWordLabel.setUILabel("", textAlignment: .left, color: Color.black, backgroundColor: .clear, font: Font.regular15, cornerRadius: 0, numberLine: 1)
    }
    
    func configureData(word: String) {
        searchWordLabel.text = word
    }
}
