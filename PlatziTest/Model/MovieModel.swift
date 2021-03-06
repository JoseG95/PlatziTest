//
//  MovieModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 05/03/21.
//

import Foundation

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
