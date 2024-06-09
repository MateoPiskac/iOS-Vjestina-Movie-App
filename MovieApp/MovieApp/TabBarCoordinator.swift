//
//  TabBarCoordinator.swift
//  MovieApp
//
//  Created by Mateo Piskac on 07.06.2024..
//

import Foundation
import UIKit

class TabBarCoordinator: BaseCoordinator {
    private var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        super.init(router: Router(navigationController: navigationController))
    }
    
    override func start() {
        let movieListNavigationController = UINavigationController()
        let movieListRouter = Router(navigationController: movieListNavigationController)
        let movieListCoordinator = MovieListCoordinator(router: movieListRouter)
        movieListCoordinator.start()
        
        let favouritesNavigationController = UINavigationController()
        let favouritesRouter = Router(navigationController: favouritesNavigationController)
        let favouritesCoordinator = FavouritesCoordinator(router: favouritesRouter)
        favouritesCoordinator.start()
        
        childCoordinators.append(movieListCoordinator)
        childCoordinators.append(favouritesCoordinator)
        
        movieListNavigationController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movies_list_unselected")?.resized(to: CGSize(width: 18, height: 18)), selectedImage: UIImage(named: "movies_list_selected")?.resized(to: CGSize(width: 18, height: 18)))
        
        favouritesNavigationController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "favourites_unselected")?.resized(to: CGSize(width: 18, height: 18)), selectedImage: UIImage(named: "favourites_selected")?.resized(to: CGSize(width: 18, height: 18)))
        
        tabBarController.viewControllers = [movieListNavigationController, favouritesNavigationController]
    }
}
