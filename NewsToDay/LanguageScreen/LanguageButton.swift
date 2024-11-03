//
//  ProfileButton.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 21.10.24.
//

import UIKit


final class LanguageButton: UIButton {
	
	
	var delegate: LanguageButtonDelegate?
	let language: Language
	
	
	// MARK: - UI Components
	
		
	// MARK: - Initializers
	init(_ language: Language) {
		self.language = language
		
		super.init(frame: .zero)
		
		
		configureButton()
		
	
		}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	@objc private func buttonTapped() {
		
		backgroundColor = .app(.purpleDark)
	}
	
	private func configureButton() {
		
		titleLabel?.font = .interFont(ofSize: 20, weight: .semibold)
		layer.cornerRadius = 15
		self.clipsToBounds = true
		contentHorizontalAlignment = .left
		
		backgroundColor = .app(.greyLighter)

		var config = UIButton.Configuration.filled()
		config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
		config.attributedTitle = AttributedString(
			language.rawValue,
			attributes: AttributeContainer(
				[NSAttributedString.Key.font: UIFont.interFont(
					ofSize: 20,
					weight: .semibold
				)]
			)
		)
		
		config.baseBackgroundColor = .app(.greyLighter)
		config.baseForegroundColor = .app(.greyDark)
		configuration = config
		
	}
	

}


protocol LanguageButtonDelegate: AnyObject {
	
	func didChangedLanguage(_ button: LanguageButton)
	
}
