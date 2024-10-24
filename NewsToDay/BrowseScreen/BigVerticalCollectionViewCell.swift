//
//  BigVerticalCollectionViewCell.swift
//  NewsToDay
//
//  Created by Олег Дербин on 24.10.2024.
//

import UIKit

class BigVerticalCollectionViewCell: UICollectionViewCell {
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chinatown")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "UI/UX Design"
        label.font = UIFont.interFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.AppColor.greyPrimary.value
        label.textAlignment = .left
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.interFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.AppColor.blackPrimary.value
        label.text = "A Simple Trick For Creating Color Palettes Quickly"
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
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
        configureUI()
    }
    
    private func configureUI() {
        addSubview(articleImageView)
        addSubview(categoriesLabel)
        addSubview(descriptionLabel)
                
        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 96),
            articleImageView.widthAnchor.constraint(equalToConstant: 96),
            
            categoriesLabel.topAnchor.constraint(equalTo: articleImageView.topAnchor, constant: 5),
            categoriesLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 16),
            categoriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: categoriesLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
}
