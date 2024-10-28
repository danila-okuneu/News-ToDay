//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit


final class CategoriesViewController: TitlesBaseViewController {
    
//    var sourceController: String?
    var sourceController: String? = "TopicsSelectionVC"
//    var sourceController: String? = "MainCategoriesVC"
    
    private var categories: [String] {
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
    
    private var selectedCategories: [String] = []
    private var categoryButtons: [UIButton] = []
    
    //MARK: - UI Elements
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        //        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    //    private let titleLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Select your favorite topics"
    //        label.font = UIFont.interFont(ofSize: 24, weight: .bold)
    //        label.textAlignment = .center
    //        label.textColor = UIColor.app(.blackPrimary)
    //        return label
    //    }()
    
    //    private let descriptionLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Select some of your favorite topics to let us suggest better news for you."
    //        label.font = UIFont.interFont(ofSize: 16)
    //        label.textColor = UIColor.app(.greyPrimary)
    //        label.numberOfLines = 0
    //        label.textAlignment = .justified
    //        return label
    //    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("next_button_title".localized(), for: .normal)
        button.titleLabel?.font = UIFont.interFont(ofSize: 16)
        button.backgroundColor = UIColor.app(.purplePrimary)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureViewForSource()
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
        
        //        view.addSubview(titleLabel)
        //        view.addSubview(descriptionLabel)
        view.addSubview(stackView)
        setupCategoriesButtons()
        view.addSubview(nextButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        //        titleLabel.snp.makeConstraints { make in
        //            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
        //            make.leading.equalToSuperview().inset(20)
        //        }
        //
        //        descriptionLabel.snp.makeConstraints { make in
        //            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        //            make.leading.trailing.equalToSuperview().inset(20)
        
        //        }
        
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
    
    private func createCategoryButton(name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name.capitalized, for: .normal)
        button.titleLabel?.font = UIFont.interFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor.app(.greyDark), for: .normal)
        button.backgroundColor = UIColor.app(.greyLighter)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(topicButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    
    private func setupCategoriesButtons() {
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
            //horizontalStack?.addArrangedSubview(categoryButtons[index])
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
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        print("tapped next")
    }
    
    @objc private func topicButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        
        if selectedCategories.contains(title) {
            selectedCategories.removeAll { $0 == title }
            sender.backgroundColor = UIColor.app(.greyLighter)
            sender.setTitleColor(UIColor.app(.greyDark), for: .normal)
        } else {
            selectedCategories.append(title)
            sender.backgroundColor = UIColor.app(.purplePrimary)
            sender.setTitleColor(.white, for: .normal)
        }
        
        print("выбранно: \(selectedCategories)")
    }
           
    
    // смена экранов
    
    private func configureViewForSource() {
        guard let source = sourceController else { return }
        
        switch source {
        case "TopicsSelectionVC":
            setTitlesNavBar(title: "categories_onboard_screen_title".localized(), description: "description_onboard_categories_title".localized())
            nextButton.setTitle("next_button_title".localized(), for: .normal)
            
        case "MainCategoriesVC":
            setTitlesNavBar(title: "categories_screen_title".localized(), description: "description_categories_title".localized())
            nextButton.setTitle("Back", for: .normal)
            nextButton.isHidden = true

        default:
            break
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
        
        configureViewForSource()
    }
  
    
}


#Preview {
    let vc = CategoriesViewController()
//    vc.sourceController = "TopicsSelectionVC"
    vc.sourceController = "MainCategoriesVC"

    return vc
}
