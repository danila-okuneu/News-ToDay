//
//  OnboardingViewController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit
import SnapKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "OnboardingCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.app(.blackDark)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
	// MARK: - Initializers
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
		contentView.layer.cornerRadius = 16
	
		contentView.addSubview(imageView)
		
		makeConstraints()
	}
	
	private func makeConstraints() {
		
		imageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
	}
}
