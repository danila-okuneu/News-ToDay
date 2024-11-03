//
//  CategoryButton.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 3.11.24.
//

import UIKit

final class CategoryButton: UIButton {
	
	let category: Category
	
	init(with category: Category) {
		self.category = category
		super.init(frame: .zero)
		
		setTitle(category.rawValue.localized().capitalized, for: .normal)
		titleLabel?.font = UIFont.interFont(ofSize: 16, weight: .semibold)
		setTitleColor(UIColor.app(.greyDark), for: .normal)
		layer.cornerRadius = 12
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func activate() {
		UIView.animate(withDuration: 0.2) {
			self.backgroundColor = .app(.purplePrimary)
			self.setTitleColor(.white, for: .normal)
		}
	}
	
	func deactivate() {
		UIView.animate(withDuration: 0.2) {
			self.backgroundColor = .app(.greyLighter)
			self.setTitleColor(.app(.greyDark), for: .normal)
		}
	}
}
