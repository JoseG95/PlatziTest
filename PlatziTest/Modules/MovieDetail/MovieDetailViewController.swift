//
//  MovieDetailViewController.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private var viewModel: MovieDetailViewModel
    
    private let recommendationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collection.register(RecommendedMovieViewCell.self, forCellWithReuseIdentifier: RecommendedMovieViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
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
        label.textAlignment = .left
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
    
    private let recommendedMoviesLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended movies"
        label.font = Fonts.captionOne
        label.textColor = Colors.primaryWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        recommendationsCollectionView.dataSource = self
        recommendationsCollectionView.delegate = self
        view.backgroundColor = Colors.backgroundFaded
        viewModelDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    init(with cellViewModel: PopularMoviesCellViewModel) {
        viewModel = MovieDetailViewModel(cellViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedMovieViewCell.identifier, for: indexPath) as? RecommendedMovieViewCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 106, height: 160)
    }
}

private extension MovieDetailViewController {
    
    func viewModelDidLoad() {
        viewModel.onMoviesFetched = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.recommendationsCollectionView.reloadData()
            }
        }
        viewModel.didLoad()
    }
    
    @objc
    private func closeVC(_: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        movieImage.image = UIImage(data: viewModel.imageData)
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        overviewTextView.text = viewModel.overview
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(movieImage)
        view.addSubview(titleLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(overviewTitleLabel)
        view.addSubview(overviewTextView)
        view.addSubview(closeButton)
        view.addSubview(recommendationsCollectionView)
        view.addSubview(recommendedMoviesLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            recommendedMoviesLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            recommendedMoviesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            recommendationsCollectionView.topAnchor.constraint(equalTo: recommendedMoviesLabel.bottomAnchor, constant: 10),
            recommendationsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            recommendationsCollectionView.heightAnchor.constraint(equalToConstant: 160),
            recommendationsCollectionView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            movieImage.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            movieImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            movieImage.widthAnchor.constraint(equalToConstant: 135),
            titleLabel.topAnchor.constraint(equalTo: recommendationsCollectionView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 2),
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
