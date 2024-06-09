//
//  MovieTableVIewCell.swift
//  MovieApp
//
//  Created by Mateo Piskac on 10.05.2024..
//

import Foundation
import UIKit
import PureLayout
import MovieAppData


class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.masksToBounds = false
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 130/255.0, green: 130/255.0, blue: 130/255.0, alpha: 1)
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        applyCornerMask()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func applyCornerMask() {
        let maskPath = UIBezierPath(roundedRect: posterImageView.bounds,
                                    byRoundingCorners: [.topLeft, .bottomLeft],
                                    cornerRadii: CGSize(width: 8, height: 8))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        posterImageView.layer.mask = shape
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerMask()  // Re-apply the mask to adjust to the layout changes
    }
    
    // MARK: - Constraints
    
    private func setupViews() {
        contentView.backgroundColor = .clear  // Ensure cell background doesn't show
        contentView.addSubview(cardView)
        
        cardView.addSubview(posterImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(summaryLabel)
        
        cardView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        
        posterImageView.autoSetDimensions(to: CGSize(width: 70, height: 100))
        posterImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        posterImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        posterImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        
        titleLabel.autoPinEdge(.left, to: .right, of: posterImageView, withOffset: 10)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        summaryLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 5)
        summaryLabel.autoPinEdge(.left, to: .right, of: posterImageView, withOffset: 10)
        summaryLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        summaryLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
    }
    
    func configure(with movie: MovieModel) {
        titleLabel.text = movie.name
        summaryLabel.text = movie.summary
        posterImageView.kf.setImage(with: URL(string : movie.imageUrl),placeholder: UIImage(named: "no_network_placeholder"))
    }
}
