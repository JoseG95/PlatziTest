//
//  PopularMoviesViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import Foundation

protocol PopularMoviesViewModelProtocol: AnyObject {
    var totalResults: Int { get }
    var onMoviesFetched: (([IndexPath]?) -> Void)? { get set }
    func getCellViewModel( at indexPath: IndexPath ) -> PopularMoviesCellViewModelProtocol?
    func fetchPopularMovies()
    func didLoad()
    var numberOfCells: Int { get }
}

class PopularMoviesViewModel {
    
    var onMoviesFetched: (([IndexPath]?) -> Void)?
    var numberOfCells: Int {
        return cellViewModels.count
    }
    private (set) var totalResults: Int = 0
    
    private var cellViewModels: [PopularMoviesCellViewModelProtocol] = []
    private var isFetchInProgress: Bool = false
    private var currentPage: Int = 1
    
}

extension PopularMoviesViewModel: PopularMoviesViewModelProtocol {
    func didLoad() {
        fetchPopularMovies()
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PopularMoviesCellViewModelProtocol? {
        return cellViewModels[safe: indexPath.row]
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
        var cellViewModels = [PopularMoviesCellViewModelProtocol]()
        for movie in movies {
            cellViewModels.append(viewModelFrom(movie))
        }
        self.cellViewModels = cellViewModels
    }
    
    func viewModelFrom(_ movie: Movie) -> PopularMoviesCellViewModelProtocol {
        return PopularMoviesCellViewModel(movie: movie)
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
