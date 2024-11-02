//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit


class BaseCategoriesViewController: TitlesBaseViewController {
    
    
    var categories: [String] {
        return [
            "business_categories_cell".localized(),
            "entertainment_categories_cell".localized(),
            "general_categories_cell".localized(),
            "health_categories_cell".localized(),
            "science_categories_cell".localized(),
            "technology_categories_cell".localized(),
            "sports_categories_cell".localized()
        ]
    }
    
     var selectedCategories: [String] = []
     var categoryButtons: [UIButton] = []
 
    
    //MARK: - UI Elements
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        return stackView
    }()
       
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("next_button_title".localized(), for: .normal)
        button.titleLabel?.font = UIFont.interFont(ofSize: 16)
        button.backgroundColor = UIColor.app(.purplePrimary)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

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
        view.addSubview(nextButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(120)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-90)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    func createCategoryButton(name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name.capitalized, for: .normal)
        button.titleLabel?.font = UIFont.interFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor.app(.greyDark), for: .normal)

        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(topicButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    
     func setupCategoriesButtons() {
        categoryButtons.removeAll()
        var horizontalStack: UIStackView?
        
        for (index, category) in categories.enumerated() {
            let button = createCategoryButton(name: category)
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
    

    
    @objc  func topicButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        let cleanTitle = title.cleanCategory()
        
        UIView.animate(withDuration: 0.3) {
            if self.selectedCategories.contains(cleanTitle) {
                self.selectedCategories.removeAll { $0 == cleanTitle }
                sender.backgroundColor = UIColor.app(.greyLighter)
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
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        print("tapped next")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let tabBarController = window.rootViewController as? TabController {
            tabBarController.selectedIndex = 0
            print("Selected Tab Index: \(tabBarController.selectedIndex)")
            
            // Проверяем, какие контроллеры есть в tabBarController
            if let navController = tabBarController.viewControllers?[0] as? UINavigationController,
               let browseVC = navController.viewControllers.first as? BrowseViewController {
                browseVC.categories = selectedCategories
                print("Selected Categories: \(selectedCategories)")
                browseVC.fetchRecomData()
            } else {
                print("BrowseViewController not found.")
            }
        }
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
            } else {
                print("Could not retrieve tab bar controller or window.")
                
            
        }
    }
    
    //MARK: - Localization
    private func addObserverForLocalization() {
        NotificationCenter.default.addObserver(forName: LanguageManager.languageDidChangeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.updateLocalizedText()
        }
    }
    
    private func removeObserverForLocalization() {
        NotificationCenter.default.removeObserver(self, name: LanguageManager.languageDidChangeNotification, object: nil)
    }
    
    @objc private func updateLocalizedText() {
        for (index, button) in categoryButtons.enumerated() {
            let localizedTitle = categories[index]
            button.setTitle(localizedTitle, for: .normal)
        }
    }
  
    
}

// MARK: Extension - String formatter

extension String {
    func cleanCategory () -> String {
        let cleanedTitle = self.replacingOccurrences(of: "^[\\W_]*|_categories_cell$", with: "", options: .regularExpression)
        return cleanedTitle
    }
}


#Preview { BaseCategoriesViewController() }

