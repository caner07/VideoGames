//
//  GamesCellCollectionViewCell.swift
//  VideoGames
//
//  Created by Caner on 21.10.2021.
//

import UIKit
import Kingfisher

class GamesCellCollectionViewCell: UICollectionViewCell {
    static let reuseID = "GamesCell"
    var gameImage = UIImageView()
    var gameNameLabel = UILabel()
    var ratingAndReleasedLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    func set(game:GamesModel?){
        guard let game = game else{return}
        gameNameLabel.text = game.name
        ratingAndReleasedLabel.text = "Rating:\(game.rating ?? 0.0) \nRelease Date:\(game.released ?? "")"
        guard let url = URL(string: game.imageUrl ?? "") else{return}
        gameImage.kf.indicatorType = .activity
        gameImage.kf.setImage(with: url)
        
        
    }
    func set(game:Game?){
        guard let game = game else{return}
        gameNameLabel.text = game.name
        ratingAndReleasedLabel.text = "Rating:\(game.rating ) \nRelease Date:\(game.released ?? "")"
        guard let url = URL(string: game.imageUrl ?? "") else{return}
        gameImage.kf.indicatorType = .activity
        gameImage.kf.setImage(with: url)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.systemGray5.cgColor
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
        gameNameLabel.textAlignment = .left
        gameNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        gameNameLabel.textColor = .label
        ratingAndReleasedLabel.textAlignment = .left
        ratingAndReleasedLabel.font = UIFont.systemFont(ofSize: 14)
        ratingAndReleasedLabel.textColor = .label
        ratingAndReleasedLabel.numberOfLines = 0
        gameNameLabel.numberOfLines = 0
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingAndReleasedLabel.translatesAutoresizingMaskIntoConstraints = false
        gameImage.translatesAutoresizingMaskIntoConstraints = false
        gameImage.layer.cornerRadius = 10
        gameImage.clipsToBounds = true
        gameNameLabel.adjustsFontSizeToFitWidth = true
        gameNameLabel.clipsToBounds = true
        addSubview(gameImage)
        addSubview(gameNameLabel)
        addSubview(ratingAndReleasedLabel)
        let padding:CGFloat = 8
        NSLayoutConstraint.activate([
            gameImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gameImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImage.widthAnchor.constraint(equalToConstant: 80),
            gameImage.trailingAnchor.constraint(equalTo: gameNameLabel.leadingAnchor,constant: -padding),
            gameImage.heightAnchor.constraint(equalToConstant: self.contentView.frame.height)
        ])
        NSLayoutConstraint.activate([
            gameNameLabel.topAnchor.constraint(equalTo: gameImage.topAnchor,constant: padding),
            gameNameLabel.leadingAnchor.constraint(equalTo: gameImage.trailingAnchor,constant: padding),
            gameNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -padding),
            gameNameLabel.bottomAnchor.constraint(equalTo: ratingAndReleasedLabel.topAnchor,constant: padding)
        ])
        NSLayoutConstraint.activate([
            ratingAndReleasedLabel.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor,constant: padding),
            ratingAndReleasedLabel.leadingAnchor.constraint(equalTo: gameNameLabel.leadingAnchor),
            ratingAndReleasedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
            ratingAndReleasedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:-padding)
        ])
    }
}
