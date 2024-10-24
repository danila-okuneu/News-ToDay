//
//  LanguageCell.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 22.10.24.
//

import UIKit
import SnapKit

final class LanguageTableViewCell: UITableViewCell {
	
	
	
	static let reusableIdentifire = "LanguageCell"
	
	var language: Language?
	
	// MARK: - UI Components
	
	private let mainView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 15
		view.backgroundColor = .app(.greyLighter)
		return view
	}()
	
	private let languageLabel: UILabel = {
		let label = UILabel()
		label.font = .interFont(ofSize: 18, weight: .semibold)
		label.textColor = .app(.greyDark)
		return label
	}()
	
	private let ckeckImageView: UIImageView = {
		
		let imageView = UIImageView()
		imageView.layer.opacity = 0
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = .white
		imageView.image = UIImage(systemName: "checkmark")
		
		return imageView
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
		selectionStyle = .none
	}
	
		required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		
		addSubview(mainView)
		mainView.addSubview(languageLabel)
		mainView.addSubview(ckeckImageView)
		
		mainView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(5)
			make.right.equalToSuperview()
			make.left.equalToSuperview()
			make.bottom.equalToSuperview().offset(-5)
		}
		
		languageLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.left.equalToSuperview().offset(20)
		}
		
		ckeckImageView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.right.equalToSuperview().offset(-15)
			make.width.height.equalTo(20)
		}
	}
	
	
	func configure(with language: Language, isSelected: Bool) {
		
		
		self.language = language

		languageLabel.text = language.name
		
		
		updateButtonSelection(for: isSelected)
	}
	
	func updateButtonSelection(for isSelected: Bool) {
		
		
		UIView.animate(withDuration: 0.3) {
			self.languageLabel.textColor = isSelected ? .white : .app(.greyDark)
			self.ckeckImageView.layer.opacity = isSelected ? 1 : 0
			self.mainView.backgroundColor = isSelected ? .app(.purplePrimary) : .app(.greyLighter)
		}
	}
}


