//
//  Coordinator.swift
//  MovieApp
//
//  Created by Mateo Piskac on 27.05.2024..
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var router: Router { get }
    
    func start()
}

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        fatalError("Start method should be implemented.")
    }
}

protocol MovieListViewControllerDelegate: AnyObject {
    func movieListViewController(_ controller: MovieListViewController, didSelectMovieWithId movieId: Int)
}

class MovieListCoordinator: BaseCoordinator, MovieListViewControllerDelegate {
    
    override func start() {
        let movieListViewController = MovieListViewController()
        movieListViewController.delegate = self
        router.push(movieListViewController)
    }
    
    func showMovieDetails(with movieId: Int) {
        print("Navigating to movie details with ID \(movieId)")  // Debug statement
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.movieId = movieId
        router.push(movieDetailsViewController)
    }
    
    // MARK: - MovieListViewControllerDelegate
    func movieListViewController(_ controller: MovieListViewController, didSelectMovieWithId movieId: Int) {
        showMovieDetails(with: movieId)
    }
}


class FavouritesCoordinator: BaseCoordinator {
    
    override func start() {
        let favouritesViewController = FavouritesViewController()
        router.push(favouritesViewController)
    }
}
