//
//  HeaderCollectionViewCell.swift
//  VideoGames
//
//  Created by Caner on 22.10.2021.
//

import UIKit

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
    func set(){
        slideImage.image = UIImage(named: "gta")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
