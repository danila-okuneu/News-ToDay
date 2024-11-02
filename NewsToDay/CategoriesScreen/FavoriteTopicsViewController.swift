//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit


final class FavoriteTopicsViewController: BaseCategoriesViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setTitlesNavBar(title: "categories_onboard_screen_title".localized(), description: "description_onboard_categories_title".localized())
        nextButton.setTitle("next_button_title".localized(), for: .normal)
        
        
    }
    override func setupCategoriesButtons() {
        
        categoryButtons.removeAll()
        var horizontalStack: UIStackView?
        
        for (index, category) in categories.enumerated() {
            let button = createCategoryButton(name: category)
            button.backgroundColor = UIColor.app(.greyLighter)
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
}


#Preview { FavoriteTopicsViewController() }
