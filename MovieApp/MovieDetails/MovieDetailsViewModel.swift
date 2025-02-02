//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import Foundation

class MovieDetailsViewModel {

    var movieDetails: MovieDetailsModel?

    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
    }

    var callback: ((ViewState) -> Void)?

    func getMovieDetails(movieId: Int) {
        callback?(.loading)
        MovieManager.shared.getMovieDetails(movieId: movieId, completion: { [weak self] response in
            guard let self else { return }
            self.callback?(.loaded)
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self.movieDetails = model
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
