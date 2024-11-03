//
//  CategoriesViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit


final class FavoriteTopicsViewController: BaseCategoriesViewController {
	
	let nextButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("no_selection_favourite".localized(), for: .normal)
		button.titleLabel?.font = UIFont.interFont(ofSize: 18, weight: .semibold)
		button.backgroundColor = UIColor.app(.purplePrimary)
		button.tintColor = .white
		button.layer.cornerRadius = 12
		return button
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

		setTitlesNavBar(title: "categories_onboard_screen_title".localized(), description: "description_onboard_categories_title".localized())
		
	}
	
	private func setupUI() {
		view.backgroundColor = .white
		view.addSubview(nextButton)
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		nextButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-90)
			make.leading.trailing.equalToSuperview().inset(20)
			make.height.equalTo(50)
		}
	}

	@objc private func nextButtonTapped(_ sender: UIButton) {
		print("tapped next")
		
		let tabController = TabController()
		if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
		   let window = windowScene.windows.first {
			window.rootViewController = tabController
			window.makeKeyAndVisible()
			
		}
	}

	
	@objc override func topicButtonTapped(_ sender: CategoryButton) {
		
		let category = sender.category
		
		if DefaultsManager.selectedCategories.contains(category) {
			DefaultsManager.selectedCategories.removeAll(where: { $0 == category } )
			sender.deactivate()
		} else {
			DefaultsManager.selectedCategories.append(category)
			sender.activate()
		}
		
		updateButtonState()
		
		print("You select: \(category.rawValue)")
		print("Actual calegories: \(DefaultsManager.selectedCategories.map( {$0.rawValue } ))")
	}
	
	func updateButtonState() {
		if DefaultsManager.selectedCategories.isEmpty {
			UIView.transition(with: nextButton, duration: 0.2, options: .transitionCrossDissolve) {
				self.nextButton.setTitle("no_selection_favourite".localized(), for: .normal)
			}
		} else {
			UIView.transition(with: nextButton, duration: 0.2, options: .transitionCrossDissolve) {
				self.nextButton.setTitle("next_button_title".localized(), for: .normal)
			}
		}
		
	}
}


#Preview { FavoriteTopicsViewController() }
