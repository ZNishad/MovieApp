//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import Foundation

class SearchViewModel {
    private var page: Int = 0
    private var movieList: [MovieModel] = []
    private var movieDetails: MovieDetailsModel?

    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
        case hideImage(Bool)
    }

    var numberOfItems: Int {
        movieList.count
    }

    func getMovieModel(index: Int) -> MovieModel? {
        movieList[index]
    }

    var callback: ((ViewState) -> Void)?

    func getSearchMovieList(search: String) {
        callback?(.loading)
        MovieManager.shared.searchMovie(page: 1, searchString: search, completion: { [weak self] response in
            guard let self else { return }
            self.callback?(.loaded)
            switch response {
            case .success(let model):
                self.page = model.page ?? 0
                self.movieList = model.results ?? []
                self.callback?(.hideImage(!self.movieList.isEmpty))
                self.callback?(.reloadData)
            case .error(let model):
                self.callback?(.error(model.errorMessage))
            }
        })
    }
}
