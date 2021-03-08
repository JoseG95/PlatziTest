//
//  PopularMoviesViewController.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 05/03/21.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    private let popularMoviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PopularMovieTableViewCell.self, forCellReuseIdentifier: PopularMovieTableViewCell.identifier)
        tableView.backgroundColor = Colors.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Moviebox")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let headerLabelBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Popular Movies"
        label.font = Fonts.captionTwo
        label.textColor = Colors.header
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewModel: PopularMoviesViewModel = {
        return PopularMoviesViewModel()
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        viewModelDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setupTableView()
        setupConstraints()
    }
}

extension PopularMoviesViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchPopularMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.totalResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularMovieTableViewCell.identifier, for: indexPath) as? PopularMovieTableViewCell else {
            return UITableViewCell()
        }
        if let cellViewModel = viewModel.getCellViewModel(at: indexPath) {
            cell.configure(with: cellViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellViewModel = viewModel.getCellViewModel(at: indexPath) else { return }
        let controller = MovieDetailViewController(with: cellViewModel)
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
}

private extension PopularMoviesViewController {
    
    func setupConstraints() {
        view.addSubview(headerImage)
        view.addSubview(popularMoviesTableView)
        view.addSubview(headerLabelBackground)
        view.addSubview(headerTitle)
        
        NSLayoutConstraint.activate([
            headerImage.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            headerImage.widthAnchor.constraint(equalToConstant: 155),
            headerImage.heightAnchor.constraint(equalToConstant: 20),
            headerImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 25),
            headerLabelBackground.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 25),
            headerLabelBackground.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerLabelBackground.heightAnchor.constraint(equalToConstant: 25),
            headerLabelBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            headerTitle.centerYAnchor.constraint(equalTo: headerLabelBackground.centerYAnchor),
            headerTitle.heightAnchor.constraint(equalTo: headerLabelBackground.heightAnchor),
            popularMoviesTableView.topAnchor.constraint(equalTo: headerLabelBackground.bottomAnchor),
            popularMoviesTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            popularMoviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularMoviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func viewModelDidLoad() {
        viewModel.onMoviesFetched = { [weak self] indexPaths in
            guard let indexPaths = indexPaths else {
                DispatchQueue.main.async { [weak self] in
                    self?.popularMoviesTableView.reloadData()
                }
                return
            }
            
            guard let self = self else { return }

            DispatchQueue.main.async {
                let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: indexPaths)
                self.popularMoviesTableView.reloadRows(at: indexPathsToReload, with: .automatic)
            }
        }
        viewModel.didLoad()
    }
    
    func setupTableView() {
        popularMoviesTableView.dataSource = self
        popularMoviesTableView.delegate = self
        popularMoviesTableView.prefetchDataSource = self
    }
    
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.numberOfCells
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = popularMoviesTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

