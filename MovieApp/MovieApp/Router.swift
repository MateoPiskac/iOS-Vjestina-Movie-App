//
//  Router.swift
//  MovieApp
//
//  Created by Mateo Piskac on 07.06.2024..
//

import Foundation
import UIKit

class Router {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        print("Pushing view controller: \(viewController)")  // Debug statement

        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.present(viewController, animated: animated, completion: nil)
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
