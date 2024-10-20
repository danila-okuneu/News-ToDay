//
//  FontExtension.swift
//  News ToDay
//
//  Created by Danila Okuneu on 20.10.24.
//

import UIKit


import UIKit

extension UIFont {

	static func interFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
		let fontDescriptor = UIFontDescriptor(fontAttributes: [
			.family: "Inter",
			.traits: [
				UIFontDescriptor.TraitKey.weight: weight
			]
		])

		return UIFont(descriptor: fontDescriptor, size: size)
	}
}


