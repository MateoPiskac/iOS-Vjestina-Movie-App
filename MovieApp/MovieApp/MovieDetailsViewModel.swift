//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Mateo Piskac on 14.06.2024..
//

import Foundation
import Combine
import MovieAppData

class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetailsModel?
    private var dataSource: MovieDataSource
    private var movieId: Int

    init(dataSource: MovieDataSource, movieId: Int) {
        self.dataSource = dataSource
        self.movieId = movieId
        fetchMovieDetails()
    }

    func fetchMovieDetails() {
        Task {
            do {
                self.movieDetails = try await dataSource.fetchMovieDetails(for: movieId)
            } catch {
                print("Error fetching movie details: \(error)")
            }
        }
    }
}
