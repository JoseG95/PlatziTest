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
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func layoutSubviews() {
        layer.borderWidth = 2
        layer.borderColor = Colors.border.cgColor
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        movieImage.image = nil
    }
    
    func configure(with viewModel: RecommendedMovieCellViewModel) {
        self.viewModel = viewModel
        self.viewModel?.onImageFetched = { [weak self] imageData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movieImage.image = UIImage(data: imageData)
            }
        }
    }
}

private extension RecommendedMovieViewCell {
    func setupConstraints() {
        contentView.addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            movieImage.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
}
