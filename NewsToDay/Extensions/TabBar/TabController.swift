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
//        nav.tabBarItem.shadow
        return nav
    }
    
    
}
#Preview { TabController()}

