//
//  ViewController.swift
//  News ToDay
//
//  Created by Danila Okuneu on 20.10.24.
//

import UIKit
import SnapKit

final class BrowseViewController: TitlesBaseViewController {
    
    var newsManager = NewsManager()
    let newsCategories = [
        "Random",
        "General",
        "Business",
        "Entertainment",
        "Health",
        "Science",
        "Sports",
        "Technology"
    ]
    var selectedIndexPath: IndexPath?
    var currentCategory = "General"
    var allNewsData: [NewsModel]?
    var displayedData: [NewsModel] = []
    var categories: [String] = ["General", "Entertainment"]
    var recomNews:[NewsModel]?
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let containerStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 22
        return $0
    }(UIStackView())
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.searchTextField.font = UIFont.interFont(ofSize: 16, weight: .regular)
        search.searchTextField.backgroundColor = UIColor.app(.greyLighter)
        search.placeholder = "search_placeholder_textfield".localized()
        return search
    }()
    
    private lazy var smallCollectionH: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(
            SmallHCollectionViewCell.self,
            forCellWithReuseIdentifier: "SmallHCollectionViewCell"
        )
        collection.tag = 1
        collection.allowsMultipleSelection = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var bigCollectionH: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(
            BigCollectionViewCell.self,
            forCellWithReuseIdentifier: "BigCollectionViewCell"
        )
        collection.tag = 2
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let header = HeaderVerticalCollection()
    
    
    
    private lazy var bigCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(
            BigVerticalCollectionViewCell.self,
            forCellWithReuseIdentifier: "BigVerticalCollectionViewCell"
        )
        collection.isScrollEnabled = false
        collection.tag = 3
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
        // MARK: LifeCycle ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        newsManager.delegate = self
        
        setupUI()
        
        newsManager.fetchByKeyWord(keyWord: currentCategory, isCategory: true)
        newsManager.fetchNews(topic: currentCategory, isCategory: true)
        fetchRecomData()
        
        header.viewAll.addTarget(self, action: #selector(viewAllTapped), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverForLocalization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverForLocalization()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setTitlesNavBar(
            title: "browse_screen_title".localized(),
            description: "description_browse_title".localized()
        )
        scrollView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(customNavBar)
        containerStackView.addArrangedSubview(searchBar)
        containerStackView.addArrangedSubview(smallCollectionH)
        containerStackView.addArrangedSubview(bigCollectionH)
        containerStackView.addArrangedSubview(header)
        containerStackView.addArrangedSubview(bigCollectionV)
        
        view.addSubview(scrollView)
        
        smallCollectionH.delegate = self
        bigCollectionH.delegate = self
        smallCollectionH.dataSource = self
        bigCollectionH.dataSource = self
        bigCollectionV.dataSource = self
        bigCollectionV.delegate = self
        
        setupLayuot()
        
    }
    
    private func setupLayuot() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        customNavBar.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.top.equalToSuperview().inset(28)
        }
        
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.equalTo(view.snp.leading).inset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
        }
        
        // Настраиваем высоту текстового поля внутри UISearchBar
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.snp.makeConstraints { make in
                make.height.equalTo(56)
                make.leading.equalTo(view.snp.leading).inset(20)
                make.trailing.equalTo(view.snp.trailing).inset(20)
            }
        }
        
        smallCollectionH.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        bigCollectionH.snp.makeConstraints { make in
            make.height.equalTo(256)
        }
        
        header.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.height.equalTo(60)
        }
        
        bigCollectionV.snp.makeConstraints { make in
            make.height.equalTo(2000)
            make.leading.equalTo(view.snp.leading).inset(20)
            make.trailing.equalToSuperview()
        }
        
    }
    
    private func updateHeightCollection() {
        bigCollectionV.snp.updateConstraints { make in
            make.height.equalTo(bigCollectionV.collectionViewLayout.collectionViewContentSize.height)
        }
    }
    
    private func animationForTuchCollection(for cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.1, animations: {
               cell.alpha = 0.3 // Устанавливаем низкую прозрачность
           }) { _ in
               UIView.animate(withDuration: 0.1) {
                   cell.alpha = 1.0 // Возвращаем к полной непрозрачности
               }
           }
    }
    
    private func loadData() {
        newsManager.fetchByKeyWord(keyWord: currentCategory, isCategory: true)
    }
    
     func fetchRecomData() {
        newsManager.fetchRandom(categories: categories) { [weak self] articles in
            guard let self = self else { return }
            self.didUpdateNews(manager: self.newsManager, news: articles, requestType: true)

            self.recomNews = articles
            DispatchQueue.main.async {
                           self.bigCollectionV.reloadData()
                       }
        }
    }
    // MARK: See All Recommendations method
    
    @objc func viewAllTapped() {
        print(categories)
        newsManager.fetchRandom(categories: categories)  { [weak self] articles in
            guard let self = self else { return }
            self.didUpdateNews(manager: self.newsManager, news: articles, requestType: nil)
            }
        }
        
        
    
    
    //MARK: - Localization
    private func addObserverForLocalization() {
        NotificationCenter.default.addObserver(
            forName: LanguageManager.languageDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateLocalizedText()
        }
    }
    
    private func removeObserverForLocalization() {
        NotificationCenter.default.removeObserver(
            self,
            name: LanguageManager.languageDidChangeNotification,
            object: nil
        )
    }
    
    func imageTapped(for image: UIImageView, isSelected: inout Bool) {
        isSelected.toggle()
        
        if isSelected {
            image.image = UIImage(systemName: "bookmark.fill")
            image.tintColor = .white
        } else {
            image.image = UIImage(systemName: "bookmark")
            image.tintColor = .white
        }
    }
    
    @objc private func updateLocalizedText() {
        searchBar.placeholder = "search_placeholder_textfield".localized()
        setTitlesNavBar(
            title: "browse_screen_title".localized(),
            description: "description_browse_title".localized()
        )
        header.updateLocalizedText()
    }
    
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch collectionView.tag {
        case 1:
            return newsCategories.count
        case 2:
            return 5
        case 3:
            return 5
        default:
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SmallHCollectionViewCell",
                for: indexPath
            ) as! SmallHCollectionViewCell
            cell.titleLabel.text = newsCategories[indexPath.item]
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "BigCollectionViewCell",
                for: indexPath
            ) as! BigCollectionViewCell
            if let allNewsData {
                displayedData = Array(allNewsData.prefix(5))
                let article = displayedData[indexPath.row]
                print(indexPath.row)
                cell.set(article: article)
                cell.categoryLabel.text = currentCategory
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigVerticalCollectionViewCell", for: indexPath) as! BigVerticalCollectionViewCell
            updateHeightCollection()
            if let allNewsData {
                displayedData = Array(allNewsData.prefix(5))
                let article = displayedData[indexPath.row]
                print(indexPath.row)
                cell.set(article: article)
//                cell.categoryLabel.text = currentCategory

            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let cell = collectionView.cellForItem(at: indexPath) as?
            SmallHCollectionViewCell {
            currentCategory = cell.titleLabel.text ?? "general"
            if let selectedIndexPath {
                if selectedIndexPath != indexPath {
                    collectionView.deselectItem(at: selectedIndexPath, animated: true)
                }
            }
            selectedIndexPath = indexPath
            if let string = cell.titleLabel.text {
                if string.lowercased() == "random" {
                    let randomCategories = [
                        "General",
                        "Business",
                        "Entertainment",
                        "Health",
                        "Science",
                        "Sports",
                        "Technology"
                    ]
                    newsManager.getRandomNews(for: randomCategories) { news in
                        self.allNewsData = news
                        DispatchQueue.main.async {
                            self.bigCollectionH.reloadData()
                        }
                    }
                } else {
                    newsManager.fetchNews(topic: string, isCategory: true)
                }
            }
        } else if let cell = collectionView.cellForItem(at: indexPath) as? BigCollectionViewCell {
            let touchLocation = collectionView.panGestureRecognizer.location(in: cell)
            if cell.bookmarkImageView.frame.contains(touchLocation) {
                imageTapped(for: cell.bookmarkImageView, isSelected: &cell.isBookmarked)
                return
            }
            animationForTuchCollection(for: cell)
            currentCategory = cell.categoryLabel.text!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                guard let self else {return}
                let articleVC = ArticleViewController()
                articleVC.article = self.displayedData[indexPath.row] 
                articleVC.topic = currentCategory
                self.navigationController?.pushViewController(articleVC, animated: true)
            }
        } else if let cell = collectionView.cellForItem(at: indexPath) as? BigVerticalCollectionViewCell {
            animationForTuchCollection(for: cell)
            currentCategory = cell.categoriesLabel.text!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                guard let self else {return}
                let articleVC = ArticleViewController()
                articleVC.article = self.recomNews![indexPath.row]
                articleVC.topic = currentCategory
                self.navigationController?.pushViewController(articleVC, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SmallHCollectionViewCell else { return }
        print(cell.titleLabel.text ?? "")
    }
    
}

extension BrowseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch collectionView.tag {
        case 1:
            let height: CGFloat = 32
            let minimumWidth: CGFloat = 80
            
            let text = newsCategories[indexPath.item]
            
            let width: CGFloat = (text as NSString).size(
                withAttributes: [.font: UIFont.interFont(ofSize: 12)]
            ).width + 16
            
            let cellWidth = max(minimumWidth, width)
            
            return CGSize(width: cellWidth, height: height)
        case 2:
            return CGSize(width: 256, height: 256)
        case 3:
            let width = collectionView.bounds.width
            let height = 96.0
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

// MARK: UISearchBarDelegate

extension BrowseViewController: UISearchBarDelegate {
    
    // поиск по кнопке энтер + закрывает клавиатуру
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text, !text.isEmpty {
            
            newsManager.fetchByKeyWord(keyWord: text)
            searchBar.text = ""
        }
        
        
    }
}
extension BrowseViewController: NewsManagerDelegate {
    
    
    func didUpdateNews(manager: NewsManager, news: [NewsModel], requestType: Bool?) {
        if requestType != nil {
            allNewsData = news
            
            DispatchQueue.main.async {
                self.bigCollectionH.reloadData()

            }
        } else {
            DispatchQueue.main.async {
                
                let recSearchVC = RecSearchViewController()
                recSearchVC.articlesData = news
                self.navigationController?.pushViewController(recSearchVC, animated: true)
            }
        }
    }
    
    
    func didFailWithError(error: Error) {
        print("Failed with error: \(error)")
    }
}

#Preview {
    BrowseViewController()
}

