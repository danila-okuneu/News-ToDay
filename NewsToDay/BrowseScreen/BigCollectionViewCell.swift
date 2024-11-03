//
//  BigCollectionViewCell.swift
//  NewsToDay
//
//  Created by Олег Дербин on 24.10.2024.
//

import UIKit

class BigCollectionViewCell: UICollectionViewCell {
    
    let newsImageView = UIImageView()
    let bookmarkImageView = UIImageView()
    let categoryLabel = UILabel()
    let discriptionLabel = UILabel()
    var isBookmarked: Bool = false {
        didSet {
            updateBoormarkImage()
        }
    }
    
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
        
        newsImageView.image = UIImage(named: "chinatown")
        newsImageView.contentMode = .scaleAspectFill
        
        newsImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(bookmarkImageView)
        bookmarkImageView.image = UIImage(systemName: "bookmark")
        bookmarkImageView.tintColor = .white
        bookmarkImageView.contentMode = .scaleAspectFit
        bookmarkImageView.isUserInteractionEnabled = true
        
        
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
    
    private func updateBoormarkImage() {
        let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
        bookmarkImageView.image = UIImage(systemName: imageName)
    }
    
    func set(article: NewsModel, isBookmarked: Bool) {
        newsImageView.image = UIImage()
        discriptionLabel.text = article.description
        
        if let urlToImage = article.urlToImage {
            
            self.didUpdateImage(from: urlToImage)
        } else {
            newsImageView.image = UIImage(named: "chinatown")
        }
        
        if isBookmarked {
            bookmarkImageView.image = UIImage(systemName: "bookmark.fill")
        } else {
            bookmarkImageView.image = UIImage(systemName: "bookmark")
        }
        bookmarkImageView.tintColor = .white
    }
    
    func didUpdateImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = newsImageView.center
        activityIndicator.hidesWhenStopped = true
        newsImageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self.newsImageView.image = image
                }
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }.resume()
    }
}
