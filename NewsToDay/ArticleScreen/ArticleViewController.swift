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
    let articleLabel = UILabel()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let authorConstLabel = UILabel()
    let shareButton = UIButton()
    let bookmarkButton = UIButton()
    let backButton = UIButton()
    let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        
        navigationItem.hidesBackButton = true

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
        categoryLabel.backgroundColor = UIColor.app(.purplePrimary)
        categoryLabel.layer.masksToBounds = true
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.font = UIFont.interFont(ofSize: 14, weight: .semibold)
        categoryLabel.textAlignment = .center
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.minimumScaleFactor = 0.5
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryLabel)
        
        titleLabel.text = "The latest situation in the presidential election"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.interFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 0
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
        
        articleLabel.text = text
        articleLabel.textColor = .black
        articleLabel.font = UIFont.interFont(ofSize: 18, weight: .regular)
        articleLabel.textColor = UIColor.app(.greyDark)
        articleLabel.numberOfLines = 0
        articleLabel.textAlignment = .justified
        articleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articleLabel)
        
        let imgConfigBook = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .medium)
        let imageBook = UIImage(systemName: "bookmark", withConfiguration: imgConfigBook)
        bookmarkButton.setImage(imageBook, for: .normal)
        bookmarkButton.tintColor = .white
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        let imgConfigShare = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .medium)
        let imageShare = UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: imgConfigShare)
        shareButton.setImage(imageShare, for: .normal)
        shareButton.tintColor = .white
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        let imgConfigBack = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .medium)
        let imageBack = UIImage(systemName: "arrow.backward", withConfiguration: imgConfigBack)
        backButton.setImage(imageBack, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        stackView.addArrangedSubview(bookmarkButton)
        stackView.addArrangedSubview(shareButton)
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.44),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -190),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 110),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            
            articleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            articleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            articleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            authorLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            authorLabel.bottomAnchor.constraint(equalTo: authorConstLabel.topAnchor, constant: -3),
            
            authorConstLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            authorConstLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            authorConstLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
         
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

        ])
        
    }
    
    @objc func bookmarkButtonTapped() {
        print("saved")
    }
    
    @objc func goBack() {
        self.navigationController?.pushViewController(BrowseViewController(), animated: true)
    }
    
    @objc func shareTapped() {
        print("share")
        
        //здесь можно поставить url или текст статьи
        let activityVC = UIActivityViewController(activityItems: [titleLabel.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
    
    
    let text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page Results source: NEP/Edison via Reuters.select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
}

#Preview { ArticleViewController() }
