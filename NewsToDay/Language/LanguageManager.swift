//
//  LanguageManager.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 23.10.24.
//

import Foundation

struct LanguageManager {
	
	static var preferedLanguage: String {
		get {
			return UserDefaults.standard.string(forKey: "preferedLanguage") ?? "en"
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "preferedLanguage")
		}
		
	}
}

extension String {
	
	func localized() -> String {
		
		
		if let path = Bundle.main.path(forResource: LanguageManager.preferedLanguage, ofType: "lproj"),
		   let bundle = Bundle(path: path) {
			print(path)
			return NSLocalizedString(self, bundle: bundle, comment: "")
		}
		
		return ""
	}	
}
