//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit


class BaseCategoriesViewController: TitlesBaseViewController {
    
    
	var categories: [Category] = Category.allCases
     var categoryButtons: [UIButton] = []
 
    
    //MARK: - UI Elements
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        return stackView
    }()
       
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserverForLocalization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverForLocalization()
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(stackView)
        setupCategoriesButtons()
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(120)
        }
        
        
    }
    
	func createButtonFor(category: Category) -> UIButton {
		let button = CategoryButton(with: category)
		button.backgroundColor = .app(.greyLighter)
		if DefaultsManager.selectedCategories.contains(category) {
			button.activate()
		}
		
        button.addTarget(self, action: #selector(topicButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    
     func setupCategoriesButtons() {
        categoryButtons.removeAll()
        var horizontalStack: UIStackView?
        
        for (index, category) in categories.enumerated() {
			let button = createButtonFor(category: category)
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
        // выравнивание
        if categories.count % 2 != 0 {
            guard let lastStack = stackView.arrangedSubviews.last as? UIStackView else { return }
            
            let emptyView = UIView()
            lastStack.addArrangedSubview(emptyView)
            
            emptyView.snp.makeConstraints { make in
                make.height.equalTo(72)
            }
        }
    }
    

    
	@objc  func topicButtonTapped(_ sender: CategoryButton) {
        
		let category = sender.category
		
		if DefaultsManager.selectedCategories.contains(category) {
			DefaultsManager.selectedCategories.removeAll(where: { $0 == category } )
			sender.deactivate()
		} else {
			DefaultsManager.selectedCategories.append(category)
			sender.activate()
		}
		
		print("You select: \(category.rawValue)")
		print("Actual calegories: \(DefaultsManager.selectedCategories.map( {$0.rawValue } ))")
    }
    
        
    //MARK: - Localization
    func addObserverForLocalization() {
        NotificationCenter.default.addObserver(forName: LanguageManager.languageDidChangeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.updateLocalizedText()
        }
    }
    
	func removeObserverForLocalization() {
        NotificationCenter.default.removeObserver(self, name: LanguageManager.languageDidChangeNotification, object: nil)
    }
    
    @objc private func updateLocalizedText() {
        for (index, button) in categoryButtons.enumerated() {
			let localizedTitle = categories[index].rawValue.localized()
			button.setTitle(localizedTitle, for: .normal)
        }
    }
  
    
}


