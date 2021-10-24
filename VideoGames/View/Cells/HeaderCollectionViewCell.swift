//
//  HeaderCollectionViewCell.swift
//  VideoGames
//
//  Created by Caner on 22.10.2021.
//

import UIKit
import Kingfisher

class HeaderCollectionViewCell: UICollectionViewCell {
    static let headerCellId = "headercell"
    var slideImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    private func configure(){
        
        slideImage.translatesAutoresizingMaskIntoConstraints = false
        slideImage.layer.cornerRadius = 10
        slideImage.clipsToBounds = true
        addSubview(slideImage)
        NSLayoutConstraint.activate([
            slideImage.widthAnchor.constraint(equalToConstant: self.frame.width),
            slideImage.heightAnchor.constraint(equalToConstant: self.frame.height)
            
        ])
    }
    func set(game:GamesModel?){
        guard let game = game else{return}
        guard let url = URL(string: game.imageUrl ?? "") else{return}
        slideImage.kf.indicatorType = .activity
        slideImage.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
