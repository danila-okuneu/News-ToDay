//
//  OnboardingViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit


final class OnboardingItemCell: UICollectionViewCell {

	// MARK: - UI Components
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	// MARK: - Initializer
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	private func setupViews() {
		contentView.clipsToBounds = true
		contentView.addSubview(imageView)
		contentView.layer.cornerRadius = 20
		
		makeConstraints()
	}
	
	private func makeConstraints() {
		
		imageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	// MARK: - Methods
	func configure(with image: UIImage?) {
		imageView.image = image
	}
}
