//
//  FavoritesViewController.swift
//  VideoGames
//
//  Created by Caner on 21.10.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    var gamesCollectionView : UICollectionView!
    lazy var containerView = UIView()
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureViewController()
        viewModel.getGames()
    }
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
    }
    private func configureCollectionView(){
        
        let width =  view.bounds.width
        let padding: CGFloat = 12
        let itemWidth = width - (padding * 2)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 80)
        gamesCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        gamesCollectionView.keyboardDismissMode = .onDrag
        view.addSubview(gamesCollectionView)
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.register(GamesCellCollectionViewCell.self, forCellWithReuseIdentifier: GamesCellCollectionViewCell.reuseID)
    }
}

extension FavoritesViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gameList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCellCollectionViewCell.reuseID, for: indexPath) as! GamesCellCollectionViewCell
        let game = viewModel.gameList?[indexPath.row]
        cell.set(game: game)
        return cell
    }
    
    
}
//MARK: - ViewModel Delegate
extension FavoritesViewController:HomeViewModelDelegate{
    func loading() {
        
    }
    func success() {
        DispatchQueue.main.async {
        
            self.gamesCollectionView.reloadData()
        }
    }
    func error(error: ErrorTypes) {
        
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert,animated: true)
        
    }
    func searchUpdate() {
        
    }
}
