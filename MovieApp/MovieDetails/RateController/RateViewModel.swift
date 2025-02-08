//
//  RateViewModel.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 08.02.25.
//

import Foundation

class RateViewModel {
    var movieDetails: MovieDetailsModel?

    enum ViewState {
        case loading
        case loaded
        case error(String)
        case setRatingSuccess(String)
    }

    var callback: ((ViewState) -> Void)?

    func setRating(movieId: Int, rating: Double) {
        callback?(.loading)
        MovieManager.shared.setRating(movieId: movieId, rating: rating, completion: {
            [weak self] response in
            guard let self else { return }
            self.callback?(.loaded)
            switch response {
            case .success(let model):
                self.callback?(.setRatingSuccess(model.statusMessage ?? ""))
            case .error(let model):
                self.callback?(.error(model.errorMessage))
            }
        })
    }
}
