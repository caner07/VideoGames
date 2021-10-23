//
//  GameHeader.swift
//  VideoGames
//
//  Created by Caner on 22.10.2021.
//

import UIKit

class GameHeader:UICollectionReusableView{
    
    static let gameHeaderIdentifier = "gameheader"
    var sliderCollectionView:UICollectionView!
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
        self.addSubview(sliderCollectionView)
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.headerCellId)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension GameHeader:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.headerCellId, for: indexPath) as! HeaderCollectionViewCell
        cell.set()
        return cell
    }
    
    
}
