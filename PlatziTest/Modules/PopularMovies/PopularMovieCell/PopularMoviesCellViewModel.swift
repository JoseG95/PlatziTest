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
    let rating: Float
    let overview: String
    let id: Int
    
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
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.rating = Float(movie.voteAverage / 10)
        self.releaseDate = PopularMoviesCellViewModel.formattedReleaseDate(from: movie.releaseDate)
        self.overview = movie.overview
    }
}

private extension PopularMoviesCellViewModel {
    
    static func formattedReleaseDate(from movieDate: String?) -> String {
        guard let movieDate = movieDate else {
            return "-"
        }
        
        let currentFormater = DateFormatter()
        currentFormater.dateFormat = "yyyy-MM-dd"
        guard let date = currentFormater.date(from: movieDate) else {
            return "-"
        }
        
        let desiredFormatter = DateFormatter()
        desiredFormatter.locale = Locale(identifier: "en_US")
        desiredFormatter.dateFormat = "MMM d, yyy"
        return desiredFormatter.string(from: date)
    }
    
    func fetchImage(posterPath: String?) {
        guard let posterPath = posterPath else { return }
        NetworkServices.getMovieImage(from: posterPath) { [weak self] data in
            guard let self = self else { return }
            self.imageData = data
        }
    }
}
