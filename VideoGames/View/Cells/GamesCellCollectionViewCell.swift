//
//  GamesCellCollectionViewCell.swift
//  VideoGames
//
//  Created by Caner on 21.10.2021.
//

import UIKit

class GamesCellCollectionViewCell: UICollectionViewCell {
    static let reuseID = "GamesCell"
    var gameImage = UIImageView()
    var gameNameLabel = UILabel()
    var ratingAndReleasedLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    func set(){
        gameNameLabel.text = "game name"
        ratingAndReleasedLabel.text = "rating and released"
        gameImage.image = UIImage(named: "gta")
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.systemGray4.cgColor
        gameNameLabel.textAlignment = .left
        gameNameLabel.font = UIFont.systemFont(ofSize: 18)
        gameNameLabel.textColor = .label
        ratingAndReleasedLabel.textAlignment = .left
        ratingAndReleasedLabel.font = UIFont.systemFont(ofSize: 18)
        ratingAndReleasedLabel.textColor = .label
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingAndReleasedLabel.translatesAutoresizingMaskIntoConstraints = false
        gameImage.translatesAutoresizingMaskIntoConstraints = false
        gameImage.layer.cornerRadius = 10
        gameImage.clipsToBounds = true
        addSubview(gameImage)
        addSubview(gameNameLabel)
        addSubview(ratingAndReleasedLabel)
        let padding:CGFloat = 8
        NSLayoutConstraint.activate([
            gameImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding),
            gameImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: padding),
            gameImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:padding),
            gameImage.widthAnchor.constraint(equalToConstant: 80),
            gameImage.heightAnchor.constraint(equalToConstant: self.contentView.frame.height-16)
        ])
        NSLayoutConstraint.activate([
            gameNameLabel.topAnchor.constraint(equalTo: gameImage.topAnchor),
            gameNameLabel.leadingAnchor.constraint(equalTo: gameImage.trailingAnchor,constant: padding),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding)
        ])
        NSLayoutConstraint.activate([
            ratingAndReleasedLabel.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor,constant: padding),
            ratingAndReleasedLabel.leadingAnchor.constraint(equalTo: gameNameLabel.leadingAnchor),
            ratingAndReleasedLabel.trailingAnchor.constraint(equalTo: gameNameLabel.trailingAnchor),
            ratingAndReleasedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:padding)
        ])
    }
}
