//
//  PopularMovieTableViewCell.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import UIKit

final class PopularMovieTableViewCell: UITableViewCell {
    static let identifier = "PopularMovieTableViewCell"
    private weak var viewModel: PopularMoviesCellViewModelProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.primaryWhite
        label.font = Fonts.bodyOne
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.primaryWhite
        label.font = Fonts.captionTwo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 1.0
        image.layer.borderColor = Colors.border.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingView: RatingView = {
        let view = RatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        releaseDateLabel.text = nil
        movieImage.image = nil
        ratingView.setProgressWithAnimation(duration: 0, value: 0)
    }
    
    func configure(with viewModel: PopularMoviesCellViewModelProtocol) {
        self.viewModel = viewModel
        self.viewModel?.onImageFetched = { [weak self] imageData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movieImage.image = UIImage(data: imageData)
            }
        }
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        DispatchQueue.main.async {
            self.ratingView.setProgressWithAnimation(value: viewModel.rating)
        }
    }
}

private extension PopularMovieTableViewCell {
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(movieImage)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            movieImage.widthAnchor.constraint(equalToConstant: 49),
            movieImage.heightAnchor.constraint(equalToConstant: 73),
            ratingView.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor),
            ratingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ratingView.widthAnchor.constraint(equalToConstant: 38),
            ratingView.heightAnchor.constraint(equalTo: ratingView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: movieImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 10),
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
}
