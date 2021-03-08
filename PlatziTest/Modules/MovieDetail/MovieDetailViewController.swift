//
//  MovieDetailViewController.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private var viewModel: MovieDetailViewModel
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 2.0
        image.layer.borderColor = Colors.border.cgColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Fonts.captionOne
        label.textColor = Colors.primaryWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Fonts.captionTwo
        label.textColor = Colors.primaryWhite
        return label
    }()
    
    private let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.font = Fonts.captionOne
        label.textColor = Colors.primaryWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.font = Fonts.bodyOne
        textView.textColor = Colors.primaryWhite
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(closeVC(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundFaded
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    init(with cellViewModel: PopularMoviesCellViewModel) {
        self.viewModel = MovieDetailViewModel(cellViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MovieDetailViewController {
    
    @objc
    private func closeVC(_: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        movieImage.image = UIImage(data: viewModel.imageData)
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        overviewTextView.text = viewModel.overview
        
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(movieImage)
        view.addSubview(titleLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(overviewTitleLabel)
        view.addSubview(overviewTextView)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            movieImage.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            movieImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            movieImage.widthAnchor.constraint(equalToConstant: 135),
            titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -50),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            releaseDateLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            overviewTitleLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 5),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 15),
            overviewTextView.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor),
            overviewTextView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 12),
            overviewTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -12),
            overviewTextView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 22),
            closeButton.heightAnchor.constraint(equalToConstant: 22),
            closeButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20)
        ])
    }
}
