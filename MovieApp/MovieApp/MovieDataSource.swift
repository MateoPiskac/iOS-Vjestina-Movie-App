//
//  MovieDataSource.swift
//  MovieApp
//
//  Created by Mateo Piskac on 10.06.2024..
//

import Foundation
import MovieAppData

class MovieDataSource {
    
    func fetchMovies(for criteria: String) async throws -> [MovieModel] {
        let urlString: String
        switch criteria {
                case "popular?criteria=FOR_RENT", "popular?criteria=IN_THEATERS", "popular?criteria=ON_TV", "popular?criteria=STREAMING":
                    urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/\(criteria)"
                case "free-to-watch?criteria=MOVIE", "free-to-watch?criteria=TV_SHOW":
                    urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/\(criteria)"
                case "trending?criteria=TODAY", "trending?criteria=THIS_WEEK":
                    urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/\(criteria)"
                default:
                    throw URLError(.badURL)
        } 
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let movies = try JSONDecoder().decode([MovieAPIModel].self, from: data)
        return movies.map { $0.toMovieModel() }
    }
    
    func fetchMovieDetails(for movieId: Int) async throws -> MovieDetailsModel {
            let urlString = "https://five-ios-api.herokuapp.com/api/v1/movie/\(movieId)/details"
            guard let url = URL(string: urlString) else { throw URLError(.badURL) }

            var request = URLRequest(url: url)
            request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")

            let (data, _) = try await URLSession.shared.data(for: request)
            let apiModel = try JSONDecoder().decode(MovieDetailsAPIModel.self, from: data)
        return apiModel.toMovieDetailsModel()
        }
}

struct MovieAPIModel: Codable {
    let id: Int
    let name: String
    let summary: String
    let imageUrl: String
    let year: Int

    func toMovieModel() -> MovieModel {
        return MovieModel(id: id, name: name, summary: summary, imageUrl: imageUrl, year: year)
    }
}

public struct MovieModel {
    public let id: Int
    public let name: String
    public let summary: String
    public let imageUrl: String
    public let year: Int

    public init(id: Int, name: String, summary: String, imageUrl: String, year: Int) {
        self.id = id
        self.name = name
        self.summary = summary
        self.imageUrl = imageUrl
        self.year = year
    }
}


public struct MovieDetailsModel: Equatable, Decodable {
    public let id: Int
    public let name: String
    public let summary: String
    public let imageUrl: String
    public let releaseDate: String
    public let year: Int
    public let duration: Int
    public let rating: Double
    public let categories: [MovieCategoryModel]
    public let crewMembers: [MovieCrewMemberModel]

    public init(
        id: Int,
        name: String,
        summary: String,
        imageUrl: String,
        releaseDate: String,
        year: Int,
        duration: Int,
        rating: Double,
        categories: [MovieCategoryModel],
        crewMembers: [MovieCrewMemberModel]
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
        self.year = year
        self.duration = duration
        self.rating = rating
        self.categories = categories
        self.crewMembers = crewMembers
    }
}

public struct MovieCrewMemberModel: Equatable, Decodable {
    public let name: String
    public let role: String

    public init(name: String, role: String) {
        self.name = name
        self.role = role
    }
}

public enum MovieCategoryModel: String, Equatable, Decodable {
    case action = "Action"
    case adventure = "Adventure"
    case comedy = "Comedy"
    case crime = "Crime"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case romance = "Romance"
    case scienceFiction = "Science Fiction"
    case thriller = "Thriller"
    case western = "Western"
}

// Temporary structure for decoding API response
struct MovieDetailsAPIModel: Decodable {
    let id: Int
    let name: String
    let summary: String
    let imageUrl: String
    let releaseDate: String
    let year: Int
    let duration: Int
    let rating: Double
    let categories: [String]
    let crewMembers: [CrewMemberAPIModel]

    func toMovieDetailsModel() -> MovieDetailsModel {
        return MovieDetailsModel(
            id: id,
            name: name,
            summary: summary,
            imageUrl: imageUrl,
            releaseDate: releaseDate,
            year: year,
            duration: duration,
            rating: rating,
            categories: categories.compactMap { MovieCategoryModel(rawValue: $0) },
            crewMembers: crewMembers.map { $0.toMovieCrewMemberModel() }
        )
    }
}

struct CrewMemberAPIModel: Decodable {
    let name: String
    let role: String

    func toMovieCrewMemberModel() -> MovieCrewMemberModel {
        return MovieCrewMemberModel(name: name, role: role)
    }
}
