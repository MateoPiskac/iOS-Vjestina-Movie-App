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


class SectionCellView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties

    private var sectionMovies : [MovieModel] = []
    var collectionView: UICollectionView!
    
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
    
    func configure(for section: Int, movies :[MovieModel]) {
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

    //MARK: - Movir Poster cell

class MoviePosterCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        applyShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdges()
        
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
    
    
    func configure(with image: String) {
        imageView.load(url: URL(string: image) ?? noURLImage!)
    }
    
}
