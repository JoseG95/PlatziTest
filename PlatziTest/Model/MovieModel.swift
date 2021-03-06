//
//  MovieModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 05/03/21.
//

import Foundation

var appiKey = "7d93b0bb995db9da3c4cbd3c8164cf41"

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
