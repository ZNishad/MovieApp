//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import Foundation

class HomeViewModel {
    private var page: Int = 0
    private var movieList: [MovieModel] = []

    var numberOfItems: Int {
        movieList.count
    }

    func movieImagePath(index: Int) -> String? {
        movieList[index].posterFullPath
    }

    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
    }

    var callback: ((ViewState) -> Void)?

//    private var coordinator: HomeCoordinator?

//    init(coordinator: HomeCoordinator?) {
//        self.coordinator = coordinator
//    }

    func didSelectMovie(index: Int) {
//        coordinator?.showMovieDetailsController(model: movieList[index])
    }

    func movieModelId(index: Int) -> Int? {
        movieList[index].id
    }

    func getTopRatedMovieList() {
        callback?(.loading)
        MovieManager.shared.getTopRated(page: 1, completion: { [weak self] response in
            guard let self else { return }
            self.callback?(.loaded)
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self.page = model.page ?? 0
                    self.movieList = Array((model.results ?? []).prefix(5))
                    self.callback?(.reloadData)
                }
            case .error(let model):
                DispatchQueue.main.async {
                    self.callback?(.error(model.errorMessage))
                }
            }
        })
    }
}
