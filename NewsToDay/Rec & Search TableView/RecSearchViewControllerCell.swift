//
//  RecSearchViewControllerCell.swift
//  NewsToDay
//
//  Created by Anna Melekhina on 25.10.2024.
//

import Foundation
import UIKit

class RecSearchViewControllerCell: UITableViewCell {
    static let reuseID = "RecSearchViewControllerCell"
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.interFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.AppColor.greyPrimary.value
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(articleImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(categoriesLabel)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImageView.widthAnchor.constraint(equalToConstant: 100),
            articleImageView.heightAnchor.constraint(equalToConstant: 100),
            
            categoriesLabel.topAnchor.constraint(equalTo: articleImageView.topAnchor, constant: 5),
            categoriesLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 16),
            categoriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func set(article: NewsModel) {
        descriptionLabel.text = article.title
        
        if let urlToImage = article.urlToImage {
            
            self.didUpdateImage(from: urlToImage)
        } else {
            articleImageView.image = UIImage(named: "chinatown")
        }
        
//        if categoriesLabel.text != nil {}
            
            
        

    }
    
    func didUpdateImage(from url: String) {
        
        guard let imageUrl = URL(string: url) else {
            DispatchQueue.main.async {
                self.articleImageView.image = UIImage(named: "chinatown")
            }
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.articleImageView.image = image
                }
            } else {
                print(error?.localizedDescription ?? "error")
                DispatchQueue.main.async {
                    self.articleImageView.image = UIImage(named: "chinatown")
                }
            }
        }.resume()
    }
}
