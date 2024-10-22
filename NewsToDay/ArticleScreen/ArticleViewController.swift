//
//  ArticleViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit

final class ArticleViewController: UIViewController {
    
    var newsManager = NewsManager()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var imageView = UIImageView()
    var categoryLabel = UILabel()
    var articleLabel = UILabel()
    var titleLabel = UILabel()
    var authorLabel = UILabel()
    let authorConstLabel = UILabel()
    let shareButton = UIButton()
    let bookmarkButton = UIButton()
    let backButton = UIButton()
    let stackView = UIStackView()
    var isBookmarked = false
    
    //это свойство формируется из рандома, для тестирования, удалить.
    var topic = "sports"
    
//    скрывает навигейшн на этом экране, чтобы наверху от СкроллВЬю не было белой полоски.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        
        
        view.backgroundColor = .white
        newsManager.delegate = self

        
        setupUI()
        
        
        
    }
    
    
    
    func setupUI() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
                 scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                 scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                 scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                 
                 contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -60),
                 contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                 contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                 contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                 contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
             ])
        
        
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
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
        contentView.addSubview(categoryLabel)
        
        titleLabel.text = "The latest situation in the presidential election"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.interFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 3
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        authorLabel.text = "John Doe"
        authorLabel.textColor = .white
        authorLabel.font = UIFont.interFont(ofSize: 13, weight: .bold)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
        
        authorConstLabel.text = "Author"
        authorConstLabel.textColor = .white
        authorConstLabel.font = UIFont.interFont(ofSize: 12, weight: .regular)
        authorConstLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorConstLabel)
        
        articleLabel.text = text
        articleLabel.textColor = .black
        articleLabel.font = UIFont.interFont(ofSize: 18, weight: .regular)
        articleLabel.textColor = UIColor.app(.greyDark)
        articleLabel.numberOfLines = 0
        articleLabel.textAlignment = .justified
        articleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleLabel)
        
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
        contentView.addSubview(backButton)
        
        stackView.addArrangedSubview(bookmarkButton)
        stackView.addArrangedSubview(shareButton)
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -190),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            categoryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 110),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 15),
            
            articleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            articleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            articleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            articleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            authorLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            authorLabel.bottomAnchor.constraint(equalTo: authorConstLabel.topAnchor, constant: -3),
            
            authorConstLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            authorConstLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            authorConstLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
        ])
   
    }
    
    @objc func bookmarkButtonTapped() {
        madeBookmark()
        
        let topics = ["Sports", "Politics","Life","Gaming","Animals","Nature","Food","Art","History","Fashion","Covid-19"]
        topic = topics.randomElement()!

        newsManager.fetchNews(topic: topic)
        print("saved")
    }
    
    @objc func goBack() {
        self.navigationController?.pushViewController(BrowseViewController(), animated: true)
    }
    
    @objc func shareTapped() {
        print("share")
        
        //здесь можно поставить текст статьи
        let activityVC = UIActivityViewController(activityItems: [articleLabel.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
    
        //пример текста, в будущем удалить
    let text = "Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page Results source: NEP/Edison via Reuters.select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters. Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races. For more detailed state results click on the States A-Z links at the bottom of this page. Results source: NEP/Edison via Reuters."
    
    private func madeBookmark(){
        isBookmarked.toggle()
        
        let imgConfigBook = UIImage.SymbolConfiguration(pointSize: 20)
        let imageBook: UIImage
        
        if isBookmarked {
            imageBook = UIImage(systemName: "bookmark.fill", withConfiguration: imgConfigBook)!
        } else {
            imageBook = UIImage(systemName: "bookmark", withConfiguration: imgConfigBook)!
        }
        
        bookmarkButton.setImage(imageBook, for: .normal)
        
    }
}

// MARK: - NewsManagerDelegate

extension ArticleViewController: NewsManagerDelegate {
    func didUpdateNews(news: NewsModel) {
        DispatchQueue.main.async {
            self.authorLabel.text = news.author
            self.titleLabel.text = news.title
            self.articleLabel.text = news.content
            
            self.categoryLabel.text = self.topic
            
        }
    }
    
    func didFailWithError(error: any Error) {
        func didFailWithError(error: any Error) {
            print(error.localizedDescription)
        }
    }
    
    
}


#Preview { ArticleViewController() }
