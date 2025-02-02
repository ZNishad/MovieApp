//
//  MovieEndpoints.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import Foundation

enum MovieEndpoints: String {
    case popular = "/popular"
    case topRated = "/top_rated"
    case nowPlaying = "/now_playing"
    case upcoming = "/upcoming"
    case search = "/search"

    static var mainPath: String {
        "/movie"
    }

    var path: String {
        MovieEndpoints.mainPath + self.rawValue
    }

    var searchPath: String {
        self.rawValue + MovieEndpoints.mainPath
    }
}
