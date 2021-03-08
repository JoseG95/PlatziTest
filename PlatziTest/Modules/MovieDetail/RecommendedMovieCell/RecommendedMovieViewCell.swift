//
//  RecommendedMovieViewCell.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import UIKit

class RecommendedMovieViewCell: UICollectionViewCell {
    static let identifier = "RecommendedMovieViewCell"
    private var viewModel: RecommendedMovieCellViewModel?
    
    override func layoutSubviews() {
        layer.borderWidth = 2
        layer.borderColor = Colors.border.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: RecommendedMovieCellViewModel) {
        self.viewModel = viewModel
        self.viewModel?.onImageFetched = { [weak self] imageData in
            guard let self = self else { return }
            print(imageData)
        }
    }
}
