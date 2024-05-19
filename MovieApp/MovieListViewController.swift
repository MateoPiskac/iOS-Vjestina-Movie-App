//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Mateo Piskac on 10.05.2024..
//

import Foundation
import UIKit
import MovieAppData
import PureLayout

class MovieListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    let popularMovies = MovieUseCase().popularMovies
    let freeMovies = MovieUseCase().freeToWatchMovies
    let trendingMovies = MovieUseCase().trendingMovies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SectionCellView.self, forCellWithReuseIdentifier: "SectionCell")
        view.addSubview(collectionView)
        
        collectionView.autoPinEdgesToSuperviewSafeArea()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1  // Assuming 3 sections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCell", for: indexPath) as? SectionCellView else {
            fatalError("Unable to dequeue SectionCell")
        }
        // Configure each section cell based on the section
        switch indexPath.item {
        case 0:
            cell.configure(for: indexPath.item, movies: popularMovies)
        case 1:
            cell.configure(for: indexPath.item, movies: freeMovies)
        case 2:
            cell.configure(for: indexPath.item, movies: trendingMovies)
        default:
            cell.configure(for: indexPath.item, movies: popularMovies)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 230)
    }
    
    
}
