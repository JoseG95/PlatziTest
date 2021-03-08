//
//  PopularMoviesViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import Foundation

class PopularMoviesViewModel {
    private var cellViewModels: [PopularMoviesCellViewModel] = []

    var onMoviesFetched: (([IndexPath]?) -> Void)?
    
    var movies: [Movie] = []
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var totalResults: Int = 0
    
    private var isFetchInProgress: Bool = false
    private var currentPage: Int = 1
    
    func getCellViewModel( at indexPath: IndexPath ) -> PopularMoviesCellViewModel? {
        return cellViewModels[safe: indexPath.row]
    }
    
    func didLoad() {
        fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
        guard !isFetchInProgress else { return }
        
        defer { isFetchInProgress = false }
        
        isFetchInProgress = true
        
        NetworkServices.fetchPopularMovies(page: currentPage) { [weak self] movies in
            guard let self = self else { return }
            self.totalResults = movies.totalResults
            for movie in movies.results {
                self.cellViewModels.append(self.viewModelFrom(movie))
            }
            
            let indexPathsToReload: [IndexPath]? = self.currentPage == 1 ? .none : self.calculateIndexPathsToReload(from: movies.results)
            self.currentPage += 1
            self.onMoviesFetched?(indexPathsToReload)
        }
    }
}

private extension PopularMoviesViewModel {
    
    func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
      let startIndex = cellViewModels.count - newMovies.count
      let endIndex = startIndex + newMovies.count
      return (startIndex ..< endIndex).map { IndexPath(row: $0, section: 0) }
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

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
