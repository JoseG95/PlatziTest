//
//  PopularMoviesCellViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import Foundation

protocol PopularMoviesCellViewModelProtocol: AnyObject {
    var onImageFetched: ((Data) -> (Void))? { get set }
    var title: String { get }
    var releaseDate: String { get }
    var rating: Float { get }
    var overview: String { get }
    var imageData: Data { get }
    var id: Int { get }
}

class PopularMoviesCellViewModel {
    private (set) var title: String
    private (set) var releaseDate: String
    private (set) var rating: Float
    private (set) var overview: String
    private (set) var id: Int
    
    var onImageFetched: ((Data) -> (Void))? {
        didSet {
            fetchImage(posterPath: posterPath)
        }
    }
    
    private (set) var imageData: Data = Data() {
        didSet {
            onImageFetched?(imageData)
        }
    }
    
    private let posterPath: String?
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.rating = Float(movie.voteAverage / 10)
        self.releaseDate = PopularMoviesCellViewModel.formattedReleaseDate(from: movie.releaseDate)
        self.overview = movie.overview
    }
}

extension PopularMoviesCellViewModel: PopularMoviesCellViewModelProtocol {}

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
        
        if let imageData = ImageCache.shared.image(for: posterPath) {
            self.imageData = imageData
            return
        }
        
        NetworkServices.getMovieImage(from: posterPath) { [weak self] data in
            guard let self = self else { return }
            self.imageData = data
            ImageCache.shared[posterPath] = data
        }
    }
}
