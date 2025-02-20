//
//  TabBarController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//


import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setValue(CustomTabBar(), forKey: "tabBar")
        let homeController = HomeController()
        let searchController = SearchController()
        let watchListController = WatchListController()
        viewControllers = [homeController, searchController, watchListController]

        tabBar.unselectedItemTintColor = .tabBarUnselected
        tabBar.tintColor = .tabBarSelected
        tabBar.backgroundColor = .pageBack

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .pageBack
        tabBar.standardAppearance = appearance

        for item in tabBar.items ?? [] {
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3) // Уменьшаем расстояние по вертикали
            item.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0) // Уменьшаем расстояние между иконкой и текстом
        }
    }
}

