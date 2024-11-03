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
		button.setTitle("next_button_title".localized(), for: .normal)
		button.titleLabel?.font = UIFont.interFont(ofSize: 16)
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
		nextButton.setTitle("next_button_title".localized(), for: .normal)
		
		
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
//		if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//		   let window = windowScene.windows.first,
//		   let tabBarController = window.rootViewController as? TabController {
//			tabBarController.selectedIndex = 0
//			print("Selected Tab Index: \(tabBarController.selectedIndex)")
//			
//			// Проверяем, какие контроллеры есть в tabBarController
//			if let navController = tabBarController.viewControllers?[0] as? UINavigationController,
//			   let browseVC = navController.viewControllers.first as? BrowseViewController {
//				browseVC.fetchRecomData()
//			} else {
//				print("BrowseViewController not found.")
//			}
//		}
//			if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//			   let window = windowScene.windows.first {
//				window.rootViewController = tabBarController
//				window.makeKeyAndVisible()
//			} else {
//				print("Could not retrieve tab bar controller or window.")
//				
//			
//		}
	}

}


#Preview { FavoriteTopicsViewController() }
