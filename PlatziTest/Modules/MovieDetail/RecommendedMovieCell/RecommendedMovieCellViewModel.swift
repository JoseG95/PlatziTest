//
//  RecommendedMovieCellViewModel.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import Foundation

protocol RecommendedMovieCellViewModelProtocol: AnyObject {
    var onImageFetched: ((Data) -> (Void))? { get set }
}

class RecommendedMovieCellViewModel {
    private let posterPath: String
    
    private var imageData: Data = Data() {
        didSet {
            onImageFetched?(imageData)
        }
    }
    
    var onImageFetched: ((Data) -> (Void))? {
        didSet {
            fetchImage(posterPath: posterPath)
        }
    }
    
    init(posterPath: String) {
        self.posterPath = posterPath
    }
}

extension RecommendedMovieCellViewModel: RecommendedMovieCellViewModelProtocol {}

private extension RecommendedMovieCellViewModel {
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
