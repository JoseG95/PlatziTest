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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "popularMovieCell")
        return tableView
    }()
    
    lazy var viewModel: PopularMoviesViewModel = {
        return PopularMoviesViewModel()
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModelDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
}

extension PopularMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularMovieCell", for: indexPath)
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.textLabel?.text = cellViewModel.title
        return cell
    }
}

private extension PopularMoviesViewController {
    
    func viewModelDidLoad() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.popularMoviesTableView.reloadData()
            }
        }
        viewModel.didLoad()
    }
    
    func setupTableViewConstraints() {
        view.addSubview(popularMoviesTableView)
        popularMoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularMoviesTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            popularMoviesTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            popularMoviesTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            popularMoviesTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func setupTableView() {
        popularMoviesTableView.dataSource = self
        setupTableViewConstraints()
    }
}

