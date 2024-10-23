//
//  Languages.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 22.10.24.
//

import Foundation

struct Languages {
	
		
	static var currentLocale = Locale.current.language.languageCode?.identifier
	
	
	
}



enum Language: String, CaseIterable {
	case ru
	case en
	case uk
	case be
	
	var value: String {
		switch self {
		case .ru: return "Русский"
		case .en: return "English"
		case .uk: return "Українська"
		case .be: return "Беларуская"
		}
	}
}

