//
//  SmallHCollectionViewCell.swift
//  NewsToDay
//
//  Created by Олег Дербин on 23.10.2024.
//

import UIKit
import SnapKit

class SmallHCollectionViewCell: UICollectionViewCell {
 
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        setupLabel()
    }
    
    private func setupLabel() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = UIColor.app(.greyLighter)
        titleLabel.text = "Category"
        titleLabel.font = UIFont.interFont(ofSize: 12, weight: .regular)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
}