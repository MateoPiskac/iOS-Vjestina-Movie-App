//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by Mateo Piskac on 11.04.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData

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
    
    
       private let gridView: ActorsGridView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           let gridView = ActorsGridView(frame: .zero, collectionViewLayout: layout)
           gridView.backgroundColor = .white
           return gridView
       }()
    
        // MARK: - Initialization
        
    init(frame: CGRect,backgroundImage: String?, title: String?, releaseDate: String?, userRating: String?, movieGenres: String?, movieDuration: String?, movieDescription: String?) {
            super.init(frame: .zero)
            setupSubviews()
            
            if let backgroundImage = backgroundImage {
                backgroundImageView.kf.setImage(with: (URL(string: backgroundImage)), placeholder: UIImage(named: "no_network_placeholder"))
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
    // maknut ovo
        override func didMoveToSuperview() {
            super.didMoveToSuperview()
            
            guard let superview = superview else {
                return
            }
            setupConstraints(with: superview)
        }
        
        // MARK: - Setup
        
     func setGridElements(crewMembers: [MovieCrewMemberModel]){
        gridView.elements=crewMembers.map { ($0.name, $0.role) }
        
        
    }
    
        private func setupSubviews() {
            addSubview(backgroundImageView)
            addSubview(ratingLabel)
            addSubview(titleLabel)
            addSubview(releaseLabel)
            addSubview(genreLabel)
            addSubview(durationLabel)
            addSubview(overviewLabel)
            addSubview(descriptionLabel)
            addSubview(gridView)
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
        
        gridView.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 20) // 20 pixels below the descriptionLabel
                gridView.autoPinEdge(toSuperviewEdge: .leading)
                gridView.autoPinEdge(toSuperviewEdge: .trailing)
                gridView.autoPinEdge(toSuperviewEdge: .bottom)

        }
    }
