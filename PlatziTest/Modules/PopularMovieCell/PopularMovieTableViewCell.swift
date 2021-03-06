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
    }
    
    func configure(with viewModel: PopularMoviesCellViewModel) {
        titleLabel.text = viewModel.title
    }
}

private extension PopularMovieTableViewCell {
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
