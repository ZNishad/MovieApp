//
//  TabBarController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class TabBarController: UITabBarController {

    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .tabBarSelected
        return view
    }()
    
    let homeController = HomeController()
    let searchController = SearchController()
    let watchListScontroller = WatchListController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .pageBack
        tabBar.addSubview(lineView)
        viewControllers = [homeController, searchController, watchListScontroller]
        tabBar.unselectedItemTintColor = .tabBarUnselected
        tabBar.tintColor = .tabBarSelected

        lineView.width(tabBar.frame.width).0
            .height(1).0
            .top(tabBar.topAnchor)
    }
}

