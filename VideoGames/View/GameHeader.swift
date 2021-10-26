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
    var pageControl = UIPageControl()
    var headerGames = [GamesModel?]()
    var delegate:GameHeaderDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        configurePageControl()
    }
    private func configureCollectionView(){
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
        sliderCollectionView.showsHorizontalScrollIndicator = false
        
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.headerCellId)
    }
    private func configurePageControl(){
        pageControl.currentPage = 1
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.clipsToBounds = false
        pageControl.layer.cornerRadius = 10
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        pageControl.backgroundColor = .systemGray.withAlphaComponent(0.5)
        pageControl.layer.zPosition = 1
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    
}
