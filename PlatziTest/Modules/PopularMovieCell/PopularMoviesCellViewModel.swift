//
//  PopularMoviesCellViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import Foundation

class PopularMoviesCellViewModel {
    let title: String
    let releaseDate: String
    
    private let posterPath: String?
    
    var imageData: Data = Data() {
        didSet {
            onImageFetched?(imageData)
        }
    }
    
    var onImageFetched: ((Data) -> (Void))? {
        didSet {
            fetchImage(posterPath: posterPath)
        }
    }
    
    init(movie: Movie) {
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.posterPath = movie.posterPath
    }
}

private extension PopularMoviesCellViewModel {
    func fetchImage(posterPath: String?) {
        guard let posterPath = posterPath else { return }
        NetworkServices.getMovieImage(from: posterPath) { [weak self] data in
            guard let self = self else { return }
            self.imageData = data
        }
    }
}
