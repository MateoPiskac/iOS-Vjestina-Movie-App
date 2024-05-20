//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Mateo Piskac on 08.04.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher




class MovieDetailsViewController: UIViewController {
    
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Details"
        
        guard let movieId = movieId,
              let details = MovieUseCase().getDetails(id: movieId) else { return }
        
        let movieTitle = "\(details.name) (\(details.year))"
        let releaseDate = reformatDate(date: details.releaseDate)
        let userRating = "\(details.rating) User Score"
        let movieGenres = (details.categories.map { enumValue -> String in
            switch enumValue {
            case .action:
                return "Action"
            case .adventure:
                return "Adventure"
            case .comedy:
                return "Comedy"
            case .crime:
                return "Crime"
            case .drama:
                return "Drama"
            case .fantasy:
                return "Fantasy"
            case .romance:
                return "Romance"
            case .scienceFiction:
                return "Science Fiction"
            case .thriller:
                return "Thriller"
            case .western:
                return "Western"
            }
        }.joined(separator: ", "))
        
        let topDetailsView = movieDetailsView(frame:   CGRect(x: 0, y: 0, width: 327, height: 300),backgroundImage: details.imageUrl, title: movieTitle, releaseDate: releaseDate,userRating: userRating, movieGenres: movieGenres, movieDuration: convertMinutesToHoursAndMinutes(details.duration), movieDescription: details.summary)
        topDetailsView.setGridElements(crewMembers: details.crewMembers)
        view.addSubview(topDetailsView)
        
        view.backgroundColor = .white
        
        //print(details)
    }
    
    func reformatDate(date: String) -> String{
        let date = "2024-04-08"
        let originalDateFormatter = DateFormatter()
        originalDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let originalDate = originalDateFormatter.date(from: date)
        let desiredDateFormatter = DateFormatter()
        desiredDateFormatter.dateFormat = "dd-MM-yyyy"
        
        let desiredDateString = desiredDateFormatter.string(from: originalDate!)
        return desiredDateString.replacingOccurrences(of: "-", with: "/")
    }
    
    func convertMinutesToHoursAndMinutes(_ minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        return String(format: "%dh %dm", hours, remainingMinutes)
    }
}



class ActorsGridView: UICollectionView {
    
    // MARK: - Properties
    
    var elements: [(title: String, subtitle: String)] = []
    
    // MARK: - Initialization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        self.register(GridCell.self, forCellWithReuseIdentifier: GridCell.reuseIdentifier)
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource

extension ActorsGridView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifier, for: indexPath) as? GridCell else {
            fatalError("Unable to dequeue GridCell")
        }
        
        let element = elements[indexPath.item]
        cell.nameLabel.text = element.title
        cell.roleLabel.text = element.subtitle
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 40) // Set each item size to 80px wide by 40px tall
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Vertical spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Horizontal spacing
    }
}


class GridCell: UICollectionViewCell {
    
    // MARK: - Grid Cell
    
    
    static let reuseIdentifier = "GridCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(roleLabel)
        
        nameLabel.autoPinEdge(toSuperviewEdge: .top)
        nameLabel.autoPinEdge(toSuperviewEdge: .leading)
        nameLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        roleLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 5)
        roleLabel.autoPinEdge(toSuperviewEdge: .leading)
        roleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        roleLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
