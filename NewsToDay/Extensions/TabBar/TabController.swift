//
//  TabController.swift
//  NewsToDay
//
//  Created by SM Team 6 on 20.10.24.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.tintColor = UIColor.app(.purplePrimary)
        self.tabBar.unselectedItemTintColor = UIColor.app(.greyLight)
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = UIColor.app(.greyLight)//

            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
        }
        

        addObserverForLocalization()
    }
	
	
    //MARK: - Tab Setup

    private func setupTabs() {
        
        
        let browse = self.createNav(with: "tab_browse".localized(), and: UIImage(systemName: "house"), vc: BrowseViewController())
        
        let categories = self.createNav(with: "tab_categories".localized(), and: UIImage(systemName: "square.grid.2x2"), vc: CategoriesViewController())
        let bookmarks = self.createNav(with: "tab_bookmarks".localized(), and: UIImage(systemName: "bookmark"), vc: BookmarksViewController())
        let profile = self.createNav(with: "tab_profile".localized(), and: UIImage(systemName: "person"), vc: ProfileViewController())

     
        self.setViewControllers([browse,categories,bookmarks,profile], animated: true)
    }
    
    
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
//        nav.tabBarItem.shadow
        return nav
    }
    
    //MARK: - Localization
    private func addObserverForLocalization() {
        NotificationCenter.default.addObserver(forName: LanguageManager.languageDidChangeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.updateLocalizedText()
        }
    }
    
    private func removeObserverForLocalization() {
        NotificationCenter.default.removeObserver(self, name: LanguageManager.languageDidChangeNotification, object: nil)
    }
    
    @objc private func updateLocalizedText() {
        if let viewControllers = self.viewControllers {
            for (index, vc) in viewControllers.enumerated() {
                switch index {
                case 0:
                    vc.tabBarItem.title = "tab_browse".localized()
                case 1:
                    vc.tabBarItem.title = "tab_categories".localized()
                case 2:
                    vc.tabBarItem.title = "tab_bookmarks".localized()
                case 3:
                    vc.tabBarItem.title = "tab_profile".localized()
                default:
                    break
                }
            }
        }
    }
    
    deinit {
        removeObserverForLocalization()
    }
    
}
#Preview { TabController()}

