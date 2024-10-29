//
//  ArticleViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit

final class ArticleViewController: UIViewController {
    
    var newsManager = NewsManager()
    var article = NewsModel(
        author: "",
        title: "",
        content: "",
        urlToImage: "",
        publishedAt: "",
        urlArticle: "",
        description: ""
    )
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var imageView = UIImageView()
    var categoryLabel = UILabel()
    var articleLabel = UILabel()
    var titleLabel = UILabel()
    var authorLabel = UILabel()
    var dateLabel = UILabel()
    let authorConstLabel = UILabel()
    let shareButton = UIButton()
    let bookmarkButton = UIButton()
    let backButton = UIButton()
    let stackView = UIStackView()
    var isBookmarked = false
    var topic = ""

    
    override func viewDidLoad() {
        
        
        view.backgroundColor = .white
//        newsManager.delegate = self

        setupUI()
        
        displayArticleDetails()
        
   
    }
    
    
//    скрывает навигейшн на этом экране, чтобы наверху от СкроллВЬю не было белой полоски.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        
        
        imageView.image = UIImage(named: "chinatown")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.text = topic
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
        
        titleLabel.textColor = .white
        titleLabel.shadowColor = .black
        titleLabel.shadowOffset = CGSize(width: 0, height: 0)
        titleLabel.layer.shadowRadius = 9
        titleLabel.layer.shadowOpacity = 0.9
        titleLabel.font = UIFont.interFont(ofSize: 20, weight: .semibold)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.2
        titleLabel.numberOfLines = 4
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        authorLabel.textColor = .white
        authorLabel.shadowColor = .black
        authorLabel.shadowOffset = CGSize(width: 0, height: 0)
        authorLabel.layer.shadowRadius = 9
        authorLabel.layer.shadowOpacity = 0.9
        authorLabel.font = UIFont.interFont(ofSize: 13, weight: .bold)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
        
        authorConstLabel.text = "Author"
        authorConstLabel.textColor = .white
        authorConstLabel.font = UIFont.interFont(ofSize: 12, weight: .regular)
        authorConstLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorConstLabel)
        
        dateLabel.textColor = .white
        dateLabel.textAlignment = .right
        dateLabel.shadowColor = .black
        dateLabel.shadowOffset = CGSize(width: 0, height: 0)
        dateLabel.layer.shadowRadius = 9
        dateLabel.layer.shadowOpacity = 0.9
        dateLabel.font = UIFont.interFont(ofSize: 13, weight: .bold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
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
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            
            articleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            articleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            articleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            articleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            authorLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10),
            authorLabel.bottomAnchor.constraint(equalTo: authorConstLabel.topAnchor, constant: -3),
            
            dateLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: authorConstLabel.topAnchor, constant: -3),
            
            authorConstLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            authorConstLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            authorConstLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -15),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
        ])
   
    }
    
        // Functions of buttons
    
    @objc func bookmarkButtonTapped() {
        madeBookmark()
        

    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func shareTapped() {
        print("share")
        
        //здесь можно поставить текст статьи + url
        let activityVC = UIActivityViewController(activityItems: [titleLabel.text ?? ""], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
    
    
    func madeBookmark(){
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

//extension ArticleViewController: NewsManagerDelegate {
//    func didUpdateNews(manager: NewsManager,news: NewsModel) {
//        DispatchQueue.main.async {
//            self.authorLabel.text = news.author
//            self.titleLabel.text = news.title
//            self.articleLabel.text = news.content + "\n\nRead more at: \n" + news.urlArticle
//            self.categoryLabel.text = self.topic
//            
//            let text = news.publishedAt
//            self.dateLabel.text = text.makeDate()
//            
//            
//            // если есть юрл и фото, то грузим фото через didUpdateImage, если нет - то заглушка
//            if let urlToImage = news.urlToImage {
//                            self.didUpdateImage(from: urlToImage)
//            } else {
//                self.imageView.image = UIImage(named: "chinatown")
//            }
//        }
//    }
//    
//    func didFailWithError(error: any Error) {
//        func didFailWithError(error: any Error) {
//            print(error.localizedDescription)
//        }
//    }
//    


extension ArticleViewController {
        private func displayArticleDetails() {
                
                titleLabel.text = article.title
            categoryLabel.text = article.category
                authorLabel.text = article.author
                dateLabel.text = article.publishedAt.makeDate()
                articleLabel.text = article.content + "\n\nRead more at: \n" + article.urlArticle

                // Загрузка изображения, если оно доступно
                if let urlToImage = article.urlToImage {
                    didUpdateImage(from: urlToImage)
                } else {
                    imageView.image = UIImage(named: "chinatown")
                }
            }

            private func didUpdateImage(from url: String) {
                guard let imageUrl = URL(string: url) else { return }
           
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    } else {
                        print(error?.localizedDescription ?? "error")
                    }
                }.resume()
            }
        }
    

extension String {
    func makeDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}

#Preview { ArticleViewController() }
