//
//  NetworkServices.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 05/03/21.
//

import Foundation

struct ServiceDefinitions {
    private static var apiKey = "7d93b0bb995db9da3c4cbd3c8164cf41"
    private static let baseUrl = "https://api.themoviedb.org/3/movie"
    static func popularMovies(page: Int) -> String {
        return "\(baseUrl)/popular?api_key=\(apiKey)&page=\(page)"
    }
}


