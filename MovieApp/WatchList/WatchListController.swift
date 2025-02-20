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
        view.addSubviews(emptyImage, watchListLabel)
        setupUI()
    }

    private lazy var watchListLabel: UILabel = {
        let label = UILabel()
        label.text = "Watch List"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let emptyImage: UIImageView = {
        let image = UIImage(resource: .emptyWatchList)
        let imageView = UIImageView(image: image)
        return imageView
    }()

    private func setupUI() {
        watchListLabel.top(view.safeAreaLayoutGuide.topAnchor, -24).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .height(27)

        emptyImage.centerX(view.centerXAnchor).0
            .centerY(view.centerYAnchor).0
            .width(252).0
            .height(190)
    }

}
