//
//  ProfileButton.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 21.10.24.
//

import UIKit


final class CustomButton: UIButton {
	
	
	// MARK: - Initializers
	init(withTitle title: String, image: String = "") {
		super.init(frame: .zero)
		
		var config = UIButton.Configuration.filled()
		config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
		config.attributedTitle = AttributedString(
			title,
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
		
		if image != "" {
			let imageView = UIImageView()
			imageView.contentMode = .scaleAspectFit
			let imageConfiguration = UIImage.SymbolConfiguration(paletteColors: [.app(.greyDark)])
			imageView.image = UIImage(systemName: image, withConfiguration: imageConfiguration)
			addSubview(imageView)
			
			
			imageView.snp.makeConstraints { make in
				make.width.height.equalTo(30)
				make.centerY.equalToSuperview()
				make.right.equalToSuperview().offset(-10)
			}
		}
		
		
		titleLabel?.font = .interFont(ofSize: 20, weight: .semibold)
		layer.cornerRadius = 15
		self.clipsToBounds = true
		contentHorizontalAlignment = .left
		
		backgroundColor = .app(.greyLighter)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	@objc private func buttonTapped() {
		
		backgroundColor = .app(.purpleDark)
	}
	
	
}


