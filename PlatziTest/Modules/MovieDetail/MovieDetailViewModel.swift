//
//  MovieDetailViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var numberOfCells: Int { get }
    var onMoviesFetched: (() -> Void)? { get set }
    var imageData: Data { get }
    var title: String { get }
    var releaseDate: String { get }
    var overview: String { get }
    func getCellViewModel( at indexPath: IndexPath ) -> RecommendedMovieCellViewModel
    func didLoad()
}

class MovieDetailViewModel {
    
    private (set) var title: String
    private (set) var overview: String
    private (set) var releaseDate: String
    private (set) var imageData: Data
    
    private let id: Int
    
    private var cellViewModels: [RecommendedMovieCellViewModel] = [] {
        didSet {
            self.onMoviesFetched?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var onMoviesFetched: (() -> Void)?
    
    init(_ movieCellViewModel: PopularMoviesCellViewModelProtocol) {
        self.title = movieCellViewModel.title
        self.overview = movieCellViewModel.overview
        self.releaseDate = movieCellViewModel.releaseDate
        self.imageData = movieCellViewModel.imageData
        self.id = movieCellViewModel.id
    }
}

extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    func didLoad() {
        fetchRecommendedMovies()
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> RecommendedMovieCellViewModel {
        return cellViewModels[indexPath.row]
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
