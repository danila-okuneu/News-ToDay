//
//  BigCollectionViewCell.swift
//  NewsToDay
//
//  Created by Олег Дербин on 24.10.2024.
//

import UIKit

class BigCollectionViewCell: UICollectionViewCell {
    
    private let newsImageView = UIImageView()
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
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        setupNewsImage()
        setupTitleLabel()
        setupCategoryLabel()
        setupDiscriptionLabel()
    }
    
    private func setupNewsImage() {
        contentView.addSubview(newsImageView)
        
        newsImageView.image = UIImage(resource: .chinatown)
        
        newsImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(bookmarkImageView)
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
        categoryLabel.font = UIFont.interFont(ofSize: 12, weight: .regular)
        categoryLabel.textColor = .white
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    private func setupDiscriptionLabel() {
        contentView.addSubview(discriptionLabel)
        
        discriptionLabel.text = "The discription of news. The discription of news."
        discriptionLabel.font = UIFont.interFont(ofSize: 16, weight: .bold)
        discriptionLabel.textColor = .white
        discriptionLabel.numberOfLines = 0
        
        discriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(5)
           
        }
    }
}
