//
//  ViewController.swift
//  News ToDay
//
//  Created by Danila Okuneu on 20.10.24.
//

import UIKit
import SnapKit

final class BrowseViewController: TitlesBaseViewController {
    
    private let containerStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.backgroundColor = .green
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Search..."
        search.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var smallCollectionH: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.register(SmallHCollectionViewCell.self, forCellWithReuseIdentifier: "SmallHCollectionViewCell")
        collection.tag = 1
        return collection
    }()
    
    private lazy var bigCollectionH: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.register(BigCollectionViewCell.self, forCellWithReuseIdentifier: "BigCollectionViewCell")
        collection.tag = 2
        return collection
    }()
    
    private lazy var bigCollectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.register(BigCollectionViewCell.self, forCellWithReuseIdentifier: "BigCollectionViewCell")
        collection.tag = 3
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .red
        setTitlesNavBar(title: "Browse", description: "Discover things of this world")
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(customNavBar)
        containerStackView.addArrangedSubview(searchController.searchBar)
        containerStackView.addArrangedSubview(smallCollectionH)
        containerStackView.addArrangedSubview(bigCollectionH)
        containerStackView.addArrangedSubview(bigCollectionV)
        smallCollectionH.delegate = self
        bigCollectionH.delegate = self
        smallCollectionH.dataSource = self
        bigCollectionH.dataSource = self
        bigCollectionV.dataSource = self
        bigCollectionV.delegate = self
        customNavBar.backgroundColor = .magenta
        setupLayuot()
    }
    
    private func setupLayuot() {
        
        containerStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        customNavBar.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        searchController.searchBar.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        smallCollectionH.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        bigCollectionH.snp.makeConstraints { make in
            make.height.equalTo(256)
        }
        
        bigCollectionV.snp.makeConstraints { make in
            make.height.equalTo(256)
            make.width.equalToSuperview()
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigCollectionViewCell", for: indexPath)
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
            let height = 130.0
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}


#Preview {
    BrowseViewController()
}
