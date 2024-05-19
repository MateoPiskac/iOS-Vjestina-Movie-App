//
//  AllMoviesViewController.swift
//  MovieApp
//
//  Created by Mateo Piskac on 10.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

class AllMoviesViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    private var movies: [MovieModel] = []
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = MovieUseCase().allMovies
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("Unable to dequeue MovieTableViewCell")
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}
