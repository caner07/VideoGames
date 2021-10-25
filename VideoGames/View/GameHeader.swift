//
//  GameHeader.swift
//  VideoGames
//
//  Created by Caner on 22.10.2021.
//

import UIKit

protocol GameHeaderDelegate{
    func didSelectGame(game:GamesModel?)
}

class GameHeader:UICollectionReusableView{
    
    static let gameHeaderIdentifier = "gameheader"
    var sliderCollectionView:UICollectionView!
    var headerGames = [GamesModel?]()
    var delegate:GameHeaderDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    private func configure(){
        let width = self.bounds.width
        let height = self.bounds.height
        let flowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 12
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: width, height: height)
        sliderCollectionView = UICollectionView(frame: self.bounds,collectionViewLayout: flowLayout)
        sliderCollectionView.isPagingEnabled = true
        sliderCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sliderCollectionView)
        sliderCollectionView.alwaysBounceHorizontal = true
        
        
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.headerCellId)
    }
    func set(games:[GamesModel?]){
        self.headerGames = games
        self.sliderCollectionView.reloadData()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension GameHeader:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.headerCellId, for: indexPath) as! HeaderCollectionViewCell
        let game = headerGames[indexPath.row]
        cell.set(game: game)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedGame = headerGames[indexPath.row]
        delegate?.didSelectGame(game: selectedGame)
    }
    
    
}
