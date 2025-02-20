//
//  WatchListController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class WatchListController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = .init(
            title: "Watch List",
            image: .watchListIcon.resizeImage(newWidth: 24),
            selectedImage: .watchListIcon.resizeImage(newWidth: 24))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pageBack
    }
}
