//
//  ArticleViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit

final class ArticleViewController: UIViewController {
    
    let imageView = UIImageView()
    let categoryLabel = UILabel()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let authorConstLabel = UILabel()
    let shareButton = UIButton()
    let bookmarkButton = UIButton()
    
    
    override func viewDidLoad() {
            
//        кнопка для нав бара.
        let navBookmarkButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(bookmarkButtonTapped))
                navigationItem.rightBarButtonItem = navBookmarkButton

        view.backgroundColor = .white
        setupUI()
        
        
    }
    
    
    
    func setupUI() {
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.text = "Politics"
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = .blue
        categoryLabel.layer.masksToBounds = true
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.font = UIFont.interFont(ofSize: 14, weight: .semibold)
        categoryLabel.textAlignment = .center
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryLabel)
        
        titleLabel.text = "The latest situation in the presidential election"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.interFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 2
        titleLabel.numberOfLines = 2                  // number of lines: 2 or 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        authorLabel.text = "John Doe"
        authorLabel.textColor = .white
        authorLabel.font = UIFont.interFont(ofSize: 13, weight: .bold)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorLabel)
        
        authorConstLabel.text = "Author"
        authorConstLabel.textColor = .white
        authorConstLabel.font = UIFont.interFont(ofSize: 12, weight: .regular)
        authorConstLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorConstLabel)
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .white
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookmarkButton)
        
        shareButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        shareButton.tintColor = .white
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shareButton)
        
        
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.44),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -190),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(equalToConstant: 80),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            
            authorLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            authorLabel.bottomAnchor.constraint(equalTo: authorConstLabel.topAnchor, constant: -3),
            
            authorConstLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            authorConstLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            authorConstLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            
            bookmarkButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            bookmarkButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -40),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24),
            
            shareButton.topAnchor.constraint(equalTo: bookmarkButton.bottomAnchor, constant: 20),
            shareButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -40),
            shareButton.widthAnchor.constraint(equalToConstant: 24),
            shareButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
    }
    
    @objc func bookmarkButtonTapped() {
        print("saved")
    }
    
    @objc func shareTapped() {
        print("share")
        
            //здесь можно поставить url или текст статьи
        let activityVC = UIActivityViewController(activityItems: [titleLabel.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
        
        

}

#Preview { ArticleViewController() }
