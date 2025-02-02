//
//  MovieManager.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import Foundation

class MovieManager {

    static let shared = MovieManager()

    private init() { }

    func getTopRated(page: Int, completion: @escaping (NetworkResponse<MovieListModel>) -> Void) {
        let path = MovieEndpoints.topRated.path
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }

    func getPopular(page: Int, completion: @escaping (NetworkResponse<MovieListModel>) -> Void) {
        let path = MovieEndpoints.popular.path
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }

    func getNowPlaying(page: Int, completion: @escaping (NetworkResponse<MovieListModel>) -> Void) {
        let path = MovieEndpoints.nowPlaying.path
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }

    func getUpComing(page: Int, completion: @escaping (NetworkResponse<MovieListModel>) -> Void) {
        let path = MovieEndpoints.upcoming.path
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }

    func searchMovie(page: Int, searchString: String, completion: @escaping (NetworkResponse<MovieListModel>) -> Void) {
        let path = MovieEndpoints.search.searchPath
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page,"query": searchString])
        NetworkManager.shared.request(model: model, completion: completion)
    }

    func setRating(movieId: Int, rating: Double, completion: @escaping (NetworkResponse<CoreModel>) -> Void) {
        let model = NetworkRequestModel(
            path: MovieEndpoints.mainPath,
            method: .post,
            pathParams: [movieId, "rating"],
            body: ["value": rating],
            queryParams: nil)
        NetworkManager.shared.request(model: model, completion: completion)
    }

    func getMovieDetails(movieId: Int, completion: @escaping (NetworkResponse<MovieDetailsModel>) -> Void) {
        let path = MovieEndpoints.mainPath + "/\(movieId)"
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: nil)
        NetworkManager.shared.request(model: model, completion: completion)
    }
}
