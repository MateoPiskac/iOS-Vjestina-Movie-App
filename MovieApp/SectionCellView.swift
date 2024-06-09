//
//  SectionCellView.swift
//  MovieApp
//
//  Created by Mateo Piskac on 10.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

protocol SectionCellViewDelegate: AnyObject {
    func didSelectMovie(movieId: Int)
}

class SectionCellView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private var sectionMovies: [MovieModel] = []
    var collectionView: UICollectionView!
    weak var delegate: SectionCellViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: "MoviePosterCell")
        addSubview(collectionView)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 10)
        collectionView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
    }
    
    func configure(for section: Int, movies: [MovieModel]) {
        sectionMovies = movies
        switch section {
        case 0:
            titleLabel.text = "What's Popular"
        case 1:
            titleLabel.text = "Free to Watch"
        case 2:
            titleLabel.text = "Trending"
        default:
            titleLabel.text = "Section \(section)"
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionMovies.count  // Number of items in each section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCell", for: indexPath) as? MoviePosterCell else {
            fatalError("Unable to dequeue MoviePosterCell")
        }
        let movie = sectionMovies[indexPath.item]
        cell.configure(with: movie.imageUrl)
        cell.tapAction = { [weak self] in
            print("Tapped on movie with ID \(movie.id)") // Debug statement
            self?.delegate?.didSelectMovie(movieId: movie.id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 122, height: 179) // Adjust based on your design
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10  // Horizontal spacing between cells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)  // Padding from the edges of the collectionView
    }
}


//MARK: - Movie Poster cell

class MoviePosterCell: UICollectionViewCell {
    
    var tapAction: (() -> Void)?
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let favoriteIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "favourite-Icon"))
        icon.contentMode = .center
        icon.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        icon.layer.cornerRadius = 16 // Half the size if the view is 32x32 for a full circle
        icon.clipsToBounds = true
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        applyShadow()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteIcon)
        
        imageView.autoPinEdgesToSuperviewEdges()
        
        favoriteIcon.autoSetDimensions(to: CGSize(width: 32, height: 32))
        favoriteIcon.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        favoriteIcon.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = false
    }
    
    private func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        contentView.layer.cornerRadius = 8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        tapAction?()
    }
    
    func configure(with image: String) {
        imageView.kf.setImage(with: URL(string: image), placeholder: UIImage(named: "no_network_placeholder"))
    }
}
