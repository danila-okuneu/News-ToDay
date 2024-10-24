//
//  ViewController.swift
//  News ToDay
//
//  Created by Danila Okuneu on 20.10.24.
//

import UIKit
import SnapKit

final class BrowseViewController: TitlesBaseViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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
        search.placeholder = "Search"
        return search
    }()
    
    private lazy var smallCollectionH: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SmallHCollectionViewCell.self, forCellWithReuseIdentifier: "SmallHCollectionViewCell")
        collection.tag = 1
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var bigCollectionH: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(BigCollectionViewCell.self, forCellWithReuseIdentifier: "BigCollectionViewCell")
        collection.tag = 2
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var bigCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(BigVerticalCollectionViewCell.self, forCellWithReuseIdentifier: "BigVerticalCollectionViewCell")
        collection.isScrollEnabled = false
        collection.tag = 3
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setTitlesNavBar(title: "Browse", description: "Discover things of this world")
        scrollView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(customNavBar)
        containerStackView.addArrangedSubview(searchBar)
        containerStackView.addArrangedSubview(smallCollectionH)
        containerStackView.addArrangedSubview(bigCollectionH)
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
    
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return 30
        case 2:
            return 30
        case 3:
            return 30
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallHCollectionViewCell", for: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigCollectionViewCell", for: indexPath)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigVerticalCollectionViewCell", for: indexPath)
            updateHeightCollection()
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
}

extension BrowseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: 80, height: 32)
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


#Preview {
    BrowseViewController()
}
