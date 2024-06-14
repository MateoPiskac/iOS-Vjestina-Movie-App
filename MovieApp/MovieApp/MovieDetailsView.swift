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

class MovieDetailsView : UIView{
    
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
        label.alpha = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Overview"
        label.alpha = 0
        
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
        label.alpha = 0
        
        return label
    }()
    
    
    private let gridView: ActorsGridView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let gridView = ActorsGridView(frame: .zero, collectionViewLayout: layout)
        gridView.backgroundColor = .white
        gridView.alpha = 0
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
    
    //MARK: - Animations
    
    
    func animateLabelsAndGridView() {
        // Initial off-screen position
        ratingLabel.transform = ratingLabel
            .transform
            .translatedBy(x: -frame.width, y: 0)
        titleLabel.transform = titleLabel
            .transform
            .translatedBy(x: -frame.width, y: 0)
        releaseLabel.transform = releaseLabel
            .transform
            .translatedBy(x: -frame.width, y: 0)
        genreLabel.transform = genreLabel
            .transform
            .translatedBy(x: -frame.width, y: 0)
        durationLabel.transform = durationLabel
            .transform
            .translatedBy(x: -frame.width, y: 0)
        overviewLabel.transform = overviewLabel
            .transform
            .translatedBy(x: -frame.width, y: 0)
        descriptionLabel.transform = descriptionLabel
            .transform
            .translatedBy(x: -frame.width, y: 0)

        // Animate labels sliding in from the left
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            self.ratingLabel.transform = .identity
            self.ratingLabel.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            self.titleLabel.transform = .identity
            self.titleLabel.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            self.releaseLabel.transform = .identity
            self.releaseLabel.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            self.genreLabel.transform = .identity
            self.genreLabel.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            self.durationLabel.transform = .identity
            self.durationLabel.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            self.overviewLabel.transform = .identity
            self.overviewLabel.alpha = 1.0
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            self.descriptionLabel.transform = .identity
            self.descriptionLabel.alpha = 1.0
        }, completion: { _ in
            // Fade in grid view after labels are done animating
            UIView.animate(withDuration: 0.3, delay: 0.1) {
                self.gridView.alpha = 1.0
            }
        })
    }
    
}

    //MARK: ActorsGridView

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
