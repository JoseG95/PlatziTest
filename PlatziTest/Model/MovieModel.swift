//
//  MovieModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 05/03/21.
//

import Foundation

struct MoviesPage: Decodable {
    let page: Int
    let results: [Movie]
    let totalResults: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case overview, title, id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
