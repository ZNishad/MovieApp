//
//  HomeCoordinator.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showMovieDetailsController(model: MovieModel) {
//        let controller = MovieDetailsController(viewModel: .init(movieModel: model))
//        navigationController.show(controller, sender: nil)

    }
}
