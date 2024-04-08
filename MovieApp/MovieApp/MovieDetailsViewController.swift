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

let noURLImage = URL(string: "https://media.istockphoto.com/id/1336657186/vector/no-wi-fi-flat-vector.jpg?s=612x612&w=0&k=20&c=HbcdNJXVwQl3UhnENheZy0VXLXVrPDebCWD9aBHVDJM=") // temporary image in case of missing image from data


class MovieDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var movieTitle = ""
        var releaseDate = ""
        var userRating = ""
        var movieGenres = ""
//        var movieCrew = [(name: String, role: String)].self
        let details = MovieUseCase().getDetails(id: 111161)
        if(details != nil){
            movieTitle = details!.name + " ("
            movieTitle = movieTitle + String(details!.year) + ")"
            releaseDate = reformatDate(date: details!.releaseDate)
            userRating = String(details!.rating) + "  User Score"
            movieGenres = (details?.categories.map { enumValue -> String in
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
            }.joined(separator: ", ")) ?? ""

            
            
            
        }
        let topDetailsView = movieDetailsView(frame:   CGRect(x: 0, y: 0, width: 327, height: 390),backgroundImage: details?.imageUrl, title: movieTitle, releaseDate: releaseDate,userRating: userRating, movieGenres: movieGenres, movieDuration: convertMinutesToHoursAndMinutes(details!.duration), movieDescription: details!.summary)
//        let gridView = ActorsGridView()
//        gridView.elements = details!.crewMembers.map(){(name: $0.name,role: $0.role)}
        view.addSubview(topDetailsView)
//        view.addSubview(gridView)
//        gridView.autoPinEdge(.top, to: .bottom, of: topDetailsView)
//        gridView.autoPinEdge(toSuperviewEdge: .leading)
//        gridView.autoPinEdge(toSuperviewEdge: .trailing)
//        gridView.autoPinEdge(toSuperviewEdge: .bottom)

        view.backgroundColor = .white

        print(details)
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

class movieDetailsView : UIView{
    
    // MARK: - Properties
        
        private let backgroundImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
    
        private let ratingLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Proxima Nova", size: 20)
            label.textColor = .white
            label.textAlignment = .left
            return label
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .white
            label.textAlignment = .left
            return label
        }()
        
        private let releaseLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .white
            label.textAlignment = .left
            return label
        }()
    
        private let genreLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .white
            label.textAlignment = .left
            return label
        }()
        private let durationLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = .white
            label.textAlignment = .left
            return label
        }()
    
        private let overviewLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.textAlignment = .left
            label.text = "Overview"
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .black
            label.textAlignment = .left
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.lineBreakStrategy = .standard
            
            return label
        }()
    
        // MARK: - Initialization
        
    init(frame: CGRect,backgroundImage: String?, title: String?, releaseDate: String?, userRating: String?, movieGenres: String?, movieDuration: String?, movieDescription: String?) {
            super.init(frame: .zero)
            setupSubviews()
            
            if let backgroundImage = backgroundImage {
                backgroundImageView.load(url: (URL(string: backgroundImage) ?? noURLImage)!)
            }
            ratingLabel.text = userRating
            titleLabel.text = title
            releaseLabel.text = releaseDate
            genreLabel.text = movieGenres
            durationLabel.text = movieDuration
            descriptionLabel.text = movieDescription
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the frame to fill the safe area
        if let superview = superview {
            frame = superview.safeAreaLayoutGuide.layoutFrame
            }
        }
        override func didMoveToSuperview() {
            super.didMoveToSuperview()
            
            guard let superview = superview else {
                return
            }
            
            setupConstraints(with: superview)
        }
        
        // MARK: - Setup
        
        private func setupSubviews() {
            addSubview(backgroundImageView)
            addSubview(ratingLabel)
            addSubview(titleLabel)
            addSubview(releaseLabel)
            addSubview(genreLabel)
            addSubview(durationLabel)
            addSubview(overviewLabel)
            addSubview(descriptionLabel)
        }
        
    private func setupConstraints(with superview: UIView) {
            backgroundImageView.autoPinEdge(toSuperviewEdge: .leading)
            backgroundImageView.autoPinEdge(toSuperviewEdge: .trailing)
            backgroundImageView.autoPinEdge(toSuperviewEdge: .top)
            backgroundImageView.autoMatch(.height, to: .height, of: self, withMultiplier: 0.4) // Set height to 1/3 of superview

            // User rating Label Constraints
            ratingLabel.autoPinEdge(.bottom, to: .top, of: titleLabel, withOffset: -20, relation: .equal)
            ratingLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
            // Title Label Constraints
            titleLabel.autoPinEdge(.bottom, to: .top, of: releaseLabel, withOffset: -25, relation: .equal)
            titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
            titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5)
            
            // Release date Label Constraints
            releaseLabel.autoPinEdge(.bottom, to: .bottom, of: genreLabel, withOffset: -20, relation: .equal)
            releaseLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
            // Genre date Label Constraints
            genreLabel.autoPinEdge(.bottom, to: .bottom, of: backgroundImageView, withOffset: -25, relation: .equal)
            genreLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
            // Genre date Label Constraints
            durationLabel.autoPinEdge(.bottom, to: .bottom, of: backgroundImageView, withOffset: -25, relation: .equal)
            durationLabel.autoPinEdge(.leading, to: .trailing, of: genreLabel, withOffset: 5)
        
            overviewLabel.autoPinEdge(.top, to: .bottom, of: backgroundImageView, withOffset: 25, relation: .equal)
            overviewLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)

        
            descriptionLabel.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 25, relation: .equal)
            descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
            descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16) // Ensure the label spans the width of the superview
            descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical) // Ensure label's height is flexible

        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right) / 2
        return CGSize(width: width, height: 100) // Adjust height as needed
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

// MARK: - Image loader


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
