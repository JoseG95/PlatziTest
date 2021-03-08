//
//  PopularMovieTableViewCell.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 06/03/21.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {
    static let identifier = "PopularMovieTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.primaryWhite
        label.font = Fonts.bodyOne
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.primaryWhite
        label.font = Fonts.captionTwo
        label.text = "sdkfasldkjd sflksdf"
        return label
    }()
    
    let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "multiply.circle.fill")
        image.layer.borderWidth = 1.0
        image.layer.borderColor = Colors.border.cgColor
        return image
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGray
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
    }
    
    func configure(with viewModel: PopularMoviesCellViewModel) {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = formattedReleaseDate(from: viewModel.releaseDate)
    }
}

private extension PopularMovieTableViewCell {
    
    func formattedReleaseDate(from movieDate: String?) -> String {
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
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(movieImage)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(separatorView)
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            movieImage.widthAnchor.constraint(equalToConstant: 49),
            movieImage.heightAnchor.constraint(equalToConstant: 73),
            titleLabel.topAnchor.constraint(equalTo: movieImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 18),
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
}
