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
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		addObserverForLocalization()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		removeObserverForLocalization()
	}
    
//    override func setupCategoriesButtons() {
//        
//        categoryButtons.removeAll()
//        var horizontalStack: UIStackView?
//        
//        for (index, category) in categories.enumerated() {
//			let button = createButtonFor(category: category)
//            button.layer.borderColor = UIColor.app(.greyLighter).cgColor
//            button.layer.borderWidth = 1.0
//            categoryButtons.append(button)
//            
//            if index % 2 == 0 {
//                horizontalStack = UIStackView()
//                horizontalStack?.axis = .horizontal
//                horizontalStack?.spacing = 16
//                horizontalStack?.distribution = .fillEqually
//                stackView.addArrangedSubview(horizontalStack!)
//            }
//            horizontalStack?.addArrangedSubview(button)
//            button.snp.makeConstraints { make in
//                make.height.equalTo(72)
//            }
//        }
//        if categories.count % 2 != 0 {
//            guard let lastStack = stackView.arrangedSubviews.last as? UIStackView else { return }
//            
//            let emptyView = UIView()
//            lastStack.addArrangedSubview(emptyView)
//            
//            emptyView.snp.makeConstraints { make in
//                make.height.equalTo(72)
//            }
//        }
//    }
    
//	@objc override func topicButtonTapped(_ sender: CategoryButton) {
//		
//		let category = sender.category
//		var isConstainsCategory = false
//		if DefaultsManager.selectedCategories.contains(category) {
//			DefaultsManager.selectedCategories.removeAll(where: { $0 == category } )
//			isConstainsCategory = true
//		} else {
//			DefaultsManager.selectedCategories.append(category)
//		}
//		
//		UIView.animate(withDuration: 0.3) {
//			
//			sender.backgroundColor = isConstainsCategory ? .app(.greyLighter) : .app(.purplePrimary)
//			sender.tintColor = isConstainsCategory ? .app(.greyDark) : .app(.purplePrimary)
//			
//		}
//		print("выбрано: \(category.rawValue)")
//		print(DefaultsManager.selectedCategories)
//		
//	}
//    
}

#Preview { CategoriesViewController() }
