//
//  FavouritesViewController.swift
//  MovieApp
//
//  Created by Mateo Piskac on 19.05.2024..
//

import Foundation
import UIKit
import Combine

class FavouritesViewController: UIViewController {
    
    private var viewModel: FavouritesViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel = FavouritesViewModel(dataSource: MovieDataSource())
        viewModel.fetchFavourites()
    }
}
