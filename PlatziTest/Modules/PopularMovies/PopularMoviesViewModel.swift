//
//  PopularMoviesViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import Foundation

class PopularMoviesViewModel {
    private var cellViewModels: [PopularMoviesCellViewModel] = [] {
        didSet {
            self.onMoviesFetched?()
        }
    }

    var onMoviesFetched: (() -> Void)?
    
    var movies: [Movie] = []
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PopularMoviesCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func didLoad() {
        fetchPopularMovies()
    }
}

private extension PopularMoviesViewModel {
    func fetchPopularMovies() {
        NetworkServices.fetchPopularMovies(page: 1) { [weak self] movies in
            guard let self = self else { return }
            self.processFetchedMovies(movies.results)
        }
    }
    
    func processFetchedMovies(_ movies: [Movie]) {
        self.movies = movies
        var cellViewModels = [PopularMoviesCellViewModel]()
        for movie in movies {
            cellViewModels.append(viewModelFrom(movie))
        }
        self.cellViewModels = cellViewModels
    }
    
    func viewModelFrom(_ movie: Movie) -> PopularMoviesCellViewModel {
        return PopularMoviesCellViewModel(movie: movie)
    }
}
