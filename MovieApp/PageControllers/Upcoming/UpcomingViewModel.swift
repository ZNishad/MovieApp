//
//  UpcomingViewModel.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import Foundation

class UpcomingViewModel {

    private var page: Int = 0
    private var movieList: [MovieModel] = []

    enum ViewState {
        case loading
        case loaded
        case errer(String)
        case reloadData
    }

    var callback: ((ViewState) -> Void)?

    var numberOfItems: Int {
        movieList.count
    }

    func cellData(index: Int) -> String? {
        movieList[index].posterFullPath
    }

    func movieModelId(index: Int) -> Int? {
        movieList[index].id
    }

    func getUpcomingMovieList() {
        callback?(.loading)
        MovieManager.shared.getUpComing(page: 1, completion: { [weak self] response in
            guard let self else { return }
            self.callback?(.loaded)
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    self.page = model.page ?? 0
                    self.movieList = model.results ?? []
                    self.callback?(.reloadData)
                }
            case .error(let model):
                DispatchQueue.main.async {
                    self.callback?(.errer(model.errorMessage))
                }
            }
        })
    }
}
