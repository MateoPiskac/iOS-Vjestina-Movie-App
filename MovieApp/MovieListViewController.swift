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
    
    fileprivate func setupBarIcons() {
        let originalImage = UIImage(named: "movies_list_unselected")
        let resizedImage = originalImage?.resized(to: CGSize(width: 18, height: 18))
        let resizedSelectedImage = UIImage(named: "movies_list_selected")?.resized(to: CGSize(width: 18, height: 18))
        self.tabBarItem = UITabBarItem(title: "Movie List", image: resizedImage, selectedImage: resizedSelectedImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .white
        self.title = "Movie List"
        setupBarIcons()
        setupCollectionView()
        self.collectionView.backgroundColor = .white
        
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
        cell.onMovieTap = { [weak self] movieId in
            self?.showMovieDetail(movieId: movieId)
        }
        return cell
    }
    private func showMovieDetail(movieId: Int) {
        let detailVC = MovieDetailsViewController()
        detailVC.movieId = movieId
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 230)
    }
    
    
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
