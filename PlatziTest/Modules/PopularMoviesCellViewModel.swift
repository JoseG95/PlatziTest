//
//  PopularMoviesCellViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import Foundation

struct PopularMoviesCellViewModel {
    let title: String
    
    init(movie: Movie) {
        self.title = movie.title
    }
}
