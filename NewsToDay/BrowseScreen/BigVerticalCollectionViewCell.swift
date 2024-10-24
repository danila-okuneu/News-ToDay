//
//  BigVerticalCollectionViewCell.swift
//  NewsToDay
//
//  Created by Олег Дербин on 24.10.2024.
//

import UIKit

class BigVerticalCollectionViewCell: UICollectionViewCell {
    
    private let bookmarkImageView = UIImageView()
    private let categoryLabel = UILabel()
    private let discriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = .brown
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        setupTitleLabel()
        setupCategoryLabel()
        setupDiscriptionLabel()
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(bookmarkImageView)
        bookmarkImageView.backgroundColor = .black
        bookmarkImageView.image = UIImage(named: "bookmark 1")
        bookmarkImageView.contentMode = .scaleAspectFit
        
        bookmarkImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(24)
            make.height.width.equalTo(24)
        }
    }
    
    private func setupCategoryLabel() {
        contentView.addSubview(categoryLabel)
        
        categoryLabel.text = "CATEGORY"
        categoryLabel.backgroundColor = .yellow
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    private func setupDiscriptionLabel() {
        contentView.addSubview(discriptionLabel)
        
        discriptionLabel.text = "The discription of news. The discription of news."
        discriptionLabel.numberOfLines = 0
        discriptionLabel.backgroundColor = .yellow
        
        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
    }
}
