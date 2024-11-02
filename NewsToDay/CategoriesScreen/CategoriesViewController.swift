//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit


final class CategoriesViewController: BaseCategoriesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitlesNavBar(title: "categories_screen_title".localized(), description: "description_categories_title".localized())
        nextButton.setTitle("Back", for: .normal)
        nextButton.isHidden = true
    }
    
    override func setupCategoriesButtons() {
        
        categoryButtons.removeAll()
        var horizontalStack: UIStackView?
        
        for (index, category) in categories.enumerated() {
            let button = createCategoryButton(name: category)
            button.layer.borderColor = UIColor.app(.greyLighter).cgColor
            button.layer.borderWidth = 1.0
            categoryButtons.append(button)
            
            if index % 2 == 0 {
                horizontalStack = UIStackView()
                horizontalStack?.axis = .horizontal
                horizontalStack?.spacing = 16
                horizontalStack?.distribution = .fillEqually
                stackView.addArrangedSubview(horizontalStack!)
            }
            horizontalStack?.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.height.equalTo(72)
            }
        }
        if categories.count % 2 != 0 {
            guard let lastStack = stackView.arrangedSubviews.last as? UIStackView else { return }
            
            let emptyView = UIView()
            lastStack.addArrangedSubview(emptyView)
            
            emptyView.snp.makeConstraints { make in
                make.height.equalTo(72)
            }
        }
    }
    
    @objc override func topicButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        let cleanTitle = title.cleanCategory()
        
        UIView.animate(withDuration: 0.3) {
            if self.selectedCategories.contains(cleanTitle) {
                self.selectedCategories.removeAll { $0 == cleanTitle }
                sender.backgroundColor = .white
                sender.setTitleColor(UIColor.app(.greyDark), for: .normal)
            } else {
                self.selectedCategories.append(cleanTitle)
                sender.backgroundColor = UIColor.app(.purplePrimary)
                sender.setTitleColor(.white, for: .normal)
            }
            
        }
            print("выбрано: \(selectedCategories)")
            print(selectedCategories)
        
    }
    
}

#Preview { CategoriesViewController() }
