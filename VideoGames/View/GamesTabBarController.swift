//
//  ViewController.swift
//  VideoGames
//
//  Created by Caner on 21.10.2021.
//

import UIKit

class GamesTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemTeal
        viewControllers = [createHomeVC(),createFavoritesVC()]
        
    }
    
    func createHomeVC() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        let homeIcon = UIImage(systemName: "house")
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    func createFavoritesVC() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = "Favorites"
        let favoritesIcon = UIImage(systemName: "star")
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: favoritesIcon, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }


}

