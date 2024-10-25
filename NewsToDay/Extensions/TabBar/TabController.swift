//
//  TabController.swift
//  NewsToDay
//
//  Created by Максим Загрядский on 25.10.2024.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.app(.purplePrimary)
        self.tabBar.unselectedItemTintColor = UIColor.app(.greyLight)
    }
    

    //MARK: - Tab Setup

    private func setupTabs() {
        
        
        let browse = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: BrowseViewController())
        let categories = self.createNav(with: "Categories", and: UIImage(systemName: "square.grid.2x2"), vc: CategoriesViewController())
        let bookmarks = self.createNav(with: "Bookmarks", and: UIImage(systemName: "bookmark"), vc: BookmarksViewController())
        let profile = self.createNav(with: "Profile", and: UIImage(systemName: "person"), vc: ProfileViewController())

     
        self.setViewControllers([browse,categories,bookmarks,profile], animated: true)
    }
    
    
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    
    
}
#Preview { TabController()}
