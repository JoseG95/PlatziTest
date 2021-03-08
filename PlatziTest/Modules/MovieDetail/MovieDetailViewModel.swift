//
//  MovieDetailViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import Foundation

class MovieDetailViewModel {
    
    let title: String
    let overview: String
    let releaseDate: String
    let imageData: Data
    let id: Int
    
    private var cellViewModels: [RecommendedMovieCellViewModel] = [] {
        didSet {
            self.onMoviesFetched?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func didLoad() {
        fetchRecommendedMovies()
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> RecommendedMovieCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    var onMoviesFetched: (() -> Void)?
    
    init(_ movieCellViewModel: PopularMoviesCellViewModel) {
        self.title = movieCellViewModel.title
        self.overview = movieCellViewModel.overview
        self.releaseDate = movieCellViewModel.releaseDate
        self.imageData = movieCellViewModel.imageData
        self.id = movieCellViewModel.id
    }
}

private extension MovieDetailViewModel {
    func fetchRecommendedMovies() {
        NetworkServices.fetchRecommendedMovies(for: id) { [weak self] movies in
            guard let self = self else { return }
            self.processRecommendedMovies(movies.results)
        }
    }
    
    func processRecommendedMovies(_ movies: [Movie]) {
        var cellViewModels = [RecommendedMovieCellViewModel]()
        for movie in movies {
            if let viewModel = viewModelFrom(movie.posterPath) {
            cellViewModels.append(viewModel)
            }
        }
        self.cellViewModels = cellViewModels
    }
    
    func viewModelFrom(_ posterPath: String?) -> RecommendedMovieCellViewModel? {
        guard let posterPath = posterPath else { return nil}
        return RecommendedMovieCellViewModel(posterPath: posterPath)
    }
}
