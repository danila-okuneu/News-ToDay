//
//  DefaultsManager.swift
//  NewsToDay
//
//  Created by Danila Okuneu on 30.10.24.
//
import Foundation

struct DefaultsManager {
	
	
	static var hasSeenOnboarding: Bool {
		get { return UserDefaults.standard.bool(forKey: "hasSeenOnboarding") }
		set { UserDefaults.standard.set(newValue, forKey: "hasSeenOnboarding") }
	}
	static var isRegistered: Bool {
		get { return UserDefaults.standard.bool(forKey: "isRegistered") }
		set { UserDefaults.standard.set(newValue, forKey: "isRegistered") }
	}
	static var hasSelectedCategories: Bool { return !selectedCategories.isEmpty }
	

	static var bookmarks: [NewsModel] {
		get {
			get(key: "bookmarks", as: [NewsModel].self) ?? []
		}
		set {
			set(data: newValue, key: "bookmarks")
		}
		
	}
	static var selectedCategories: [Category] = [.business] {
		didSet {
			set(data: selectedCategories, key: "selectedCategories")
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
		selectedCategories = get(key: "selectedCategories", as: [Category].self) ?? []
	}
	
	
	static func set(data: Codable, key: String) {
		let encodedData = try? JSONEncoder().encode(data)
		UserDefaults.standard.set(encodedData, forKey: key)
		
	}
	
	static func get<T: Codable>(key: String, as type: T.Type) -> T? {
		guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
		
		return try? JSONDecoder().decode(type.self, from: data)
	}
	
	
}
