//
//  CollectionItems.swift
//  CarouselDemo
//
//  Created by Danila Okuneu on 2.11.24.
//

import UIKit

struct CarouselItems {
	
	static let imageNames: [String] = ["chinatown", "handLuggage", "timesquare"]
	
	
	static func makeItems() -> [Item] {
		return imageNames.map { Item(image: UIImage(named: $0)) }
	}
}


struct Item: Hashable {
	let image: UIImage?
}
