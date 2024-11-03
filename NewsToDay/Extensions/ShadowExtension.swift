//
//  ShadowExtension.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 3.11.24.
//

import UIKit

extension UIView {
	
	func dropShadow() {
		self.layer.shadowColor = UIColor.black.cgColor
		self.clipsToBounds = false
		self.layer.shadowOpacity = 0.5
		self.layer.shadowRadius = 20
	}
}
