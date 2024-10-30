//
//  DefaultsManager.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 30.10.24.
//
import Foundation

struct DefaultsManager {
	
	static var isFirstOpen: Bool {
		get {
			return !UserDefaults.standard.bool(forKey: "isFirstOpen")
		}
		set {
			return UserDefaults.standard.set(newValue, forKey: "isFirstOpen")
		}
	}
	static var bookmarks: [NewsModel] {
		get {
			get(key: "bookmarks", as: [NewsModel].self) ?? []
		}
		set {
			set(data: newValue, key: "bookmarks")
		}
		
	}
	static var selectedCategories: [String] {
		get {
			return (UserDefaults.standard.array(forKey: "selectedCategories") as! [String]?) ?? []
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "selectedCategories")
		}
		
	}
	// Будет подгружаться единожды при запуске, в отличие от остальных
	// т.к. get будет использоватсья часто, а куча запросов к UD - такое себе
	static var selectedLocale: String = Locale.current.language.languageCode?.identifier ?? "en" {
		didSet {
			UserDefaults.standard.set(selectedLocale, forKey: "selectedLocale")
		}
	}
	
	
	static func loadData() {
		selectedLocale = UserDefaults.standard.string(forKey: "selectedLocale") ?? "en"
	}
	
	
	static func set(data: Codable, key: String) {
		UserDefaults.standard.set(data, forKey: key)
		
	}
	
	static func get<T: Codable>(key: String, as type: T.Type) -> T? {
		guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
		
		return try? JSONDecoder().decode(type.self, from: data)
	}
}
