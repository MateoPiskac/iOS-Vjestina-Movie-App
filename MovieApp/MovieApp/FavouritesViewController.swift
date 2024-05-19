//
//  FavouritesViewController.swift
//  MovieApp
//
//  Created by Mateo Piskac on 19.05.2024..
//

import Foundation
import UIKit


class FavouritesViewController: UIViewController {
    
    fileprivate func setupBarIcons() {
        let originalImage = UIImage(named: "favourites_unselected")
        let resizedImage = originalImage?.resized(to: CGSize(width: 18, height: 18))
        let resizedSelectedImage = UIImage(named: "favourites_selected")?.resized(to: CGSize(width: 18, height: 18))
        self.tabBarItem = UITabBarItem(title: "Favourites", image: resizedImage, selectedImage: resizedSelectedImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarIcons()

    }
    
    
    
    
    
}
