//
//  FavouritesViewModel.swift
//  MovieApp
//
//  Created by Mateo Piskac on 10.06.2024..
//

import Foundation
import Combine

class FavouritesViewModel: ObservableObject {
    @Published var favourites: [MovieModel] = []
    private var dataSource: MovieDataSource

    init(dataSource: MovieDataSource) {
        self.dataSource = dataSource
    }

    func fetchFavourites() {
        Task {
            do {
                self.favourites = try await dataSource.fetchMovies(for: "FAVOURITE_CRITERIA") // TODO: Replace with actual criteria
            } catch {
                print("Error fetching favourites: \(error)")
            }
        }
    }
}
