//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Mateo Piskac on 10.06.2024..
//

import Foundation
import Combine
import MovieAppData

class MovieListViewModel: ObservableObject {
    @Published var popularMovies: [MovieModel] = []
    @Published var freeMovies: [MovieModel] = []
    @Published var trendingMovies: [MovieModel] = []

    private var dataSource: MovieDataSource

    init(dataSource: MovieDataSource) {
        self.dataSource = dataSource
    }

    func fetchMovies(completion: @escaping () -> Void) {
            Task {
                do {
                    let popularForRent = try await dataSource.fetchMovies(for: "popular?criteria=FOR_RENT")
                    let popularInTheaters = try await dataSource.fetchMovies(for: "popular?criteria=IN_THEATERS")
                    let popularOnTv = try await dataSource.fetchMovies(for: "popular?criteria=ON_TV")
                    let popularStreaming = try await dataSource.fetchMovies(for: "popular?criteria=STREAMING")
                    let freeMovies = try await dataSource.fetchMovies(for: "free-to-watch?criteria=MOVIE")
                    let freeTvShows = try await dataSource.fetchMovies(for: "free-to-watch?criteria=TV_SHOW")
                    let trendingToday = try await dataSource.fetchMovies(for: "trending?criteria=TODAY")
                    let trendingThisWeek = try await dataSource.fetchMovies(for: "trending?criteria=THIS_WEEK")

                    self.popularMovies = self.removeDuplicates(from: popularForRent + popularInTheaters + popularOnTv + popularStreaming)
                    self.freeMovies = self.removeDuplicates(from: freeMovies + freeTvShows)
                    self.trendingMovies = self.removeDuplicates(from: trendingToday + trendingThisWeek)
                    
                    completion()
                } catch {
                    print("Error fetching movies: \(error)")
                }
            }
        }

        private func removeDuplicates(from movies: [MovieModel]) -> [MovieModel] {
            var seen = Set<Int>()
            return movies.filter { movie in
                guard !seen.contains(movie.id) else { return false }
                seen.insert(movie.id)
                return true
            }
        }
}
