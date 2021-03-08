//
//  MovieDetailViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import Foundation

struct MovieDetailViewModel {
    
    let title: String
    let overview: String
    let releaseDate: String
    let imageData: Data
    let id: Int
    
    init(_ movieCellViewModel: PopularMoviesCellViewModel) {
        self.title = movieCellViewModel.title
        self.overview = movieCellViewModel.overview
        self.releaseDate = movieCellViewModel.releaseDate
        self.imageData = movieCellViewModel.imageData
        self.id = movieCellViewModel.id
    }
}
