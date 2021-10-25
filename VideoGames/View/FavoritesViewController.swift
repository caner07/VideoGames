//
//  FavoritesViewController.swift
//  VideoGames
//
//  Created by Caner on 21.10.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    var gamesCollectionView : UICollectionView!
    var searchBar:UISearchBar!
    var containerView = UIView()
    let viewModel = FavoritesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureViewController()
        
    }
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        configureSearchBar()
    }
    private func configureSearchBar(){
        searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        viewModel.getFavoriteGames(managedContext)
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
//MARK: - Collection View
extension FavoritesViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredGameList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCellCollectionViewCell.reuseID, for: indexPath) as! GamesCellCollectionViewCell
        let game = viewModel.filteredGameList?[indexPath.row]
        cell.set(game: game)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGame = viewModel.filteredGameList?[indexPath.row]
        let vc = GameDetailsViewController(gameId: Int(selectedGame?.id ?? 0),rating: selectedGame?.rating ?? 0.0 )
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    
}
//MARK: - Search Bar
extension FavoritesViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        viewModel.searchInFavorites(managedContext, searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
//MARK: - ViewModel Delegate
extension FavoritesViewController:FavoritesViewModelDelegate{
    func reload() {
        DispatchQueue.main.async {
            self.gamesCollectionView.reloadData()
        }
    }
}
