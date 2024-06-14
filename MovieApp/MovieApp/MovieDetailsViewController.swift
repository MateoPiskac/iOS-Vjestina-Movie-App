//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Mateo Piskac on 08.04.2024..
//

// MovieDetailsViewController.swift
// MovieApp

import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher
import Combine

class MovieDetailsViewController: UIViewController {
    
    var movieId: Int?
    private var topDetailsView: MovieDetailsView?
    private var viewModel: MovieDetailsViewModel!
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Details"
        view.backgroundColor = .white
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.topDetailsView?.animateLabelsAndGridView()
    }
    
    private func setupBindings() {
        guard let movieId = movieId else { return }
        self.viewModel = MovieDetailsViewModel(dataSource: MovieDataSource(), movieId: movieId)
        
        viewModel.$movieDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movieDetails in
                self?.updateUI(with: movieDetails)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(with details: MovieDetailsModel?) {
        guard let details = details else { return }
        
        let movieTitle = "\(details.name) (\(details.year))"
        let releaseDate = reformatDate(date: details.releaseDate)
        let userRating = "\(details.rating) User Score"
        let movieGenres = details.categories.map { $0.description }.joined(separator: ", ")
        
        topDetailsView = MovieDetailsView(
            frame: CGRect.zero,
            backgroundImage: details.imageUrl,
            title: movieTitle,
            releaseDate: releaseDate,
            userRating: userRating,
            movieGenres: movieGenres,
            movieDuration: convertMinutesToHoursAndMinutes(details.duration),
            movieDescription: details.summary
        )
        topDetailsView!.setGridElements(crewMembers: details.crewMembers)
        view.addSubview(topDetailsView!)
        topDetailsView?.autoPinEdgesToSuperviewEdges()
    }
    
    private func reformatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let originalDate = dateFormatter.date(from: date) else { return date }
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let desiredDateString = dateFormatter.string(from: originalDate)
        return desiredDateString.replacingOccurrences(of: "-", with: "/")
    }
    
    private func convertMinutesToHoursAndMinutes(_ minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return String(format: "%dh %dm", hours, remainingMinutes)
    }
}

extension MovieCategoryModel: CustomStringConvertible {
    public var description: String {
        switch self {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .drama: return "Drama"
        case .fantasy: return "Fantasy"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .thriller: return "Thriller"
        case .western: return "Western"
        }
    }
}


