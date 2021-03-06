//
//  ViewController.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 05/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    let popularMoviesTableView = UITableView()
    
    var characters = ["Movie1", "Movie2", "Movie3", "Movie4"]


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularMovieCell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.row]
        return cell
    }
}

private extension ViewController {
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
        popularMoviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "popularMovieCell")
        setupTableViewConstraints()
    }
}

