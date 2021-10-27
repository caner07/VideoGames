//
//  HomeViewController.swift
//  VideoGames
//
//  Created by Caner on 21.10.2021.
//

import UIKit

class HomeViewController: LoadingViewController {
    var searchBar:UISearchBar!
    var gamesCollectionView : UICollectionView!
    var notFoundLabel = UILabel()
    private let refreshControl = UIRefreshControl()
    var isSearching = false
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        viewModel.delegate = self
        viewModel.getGames()
       
    }
    
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        configureSearchBar()
        configureNotFoundLabel()
        
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
        gamesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gamesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gamesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gamesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gamesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -padding)
        ])
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        
        gamesCollectionView.register(GamesCellCollectionViewCell.self, forCellWithReuseIdentifier: GamesCellCollectionViewCell.reuseID)
        gamesCollectionView.register(GameHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GameHeader.gameHeaderIdentifier)
        
        gamesCollectionView.alwaysBounceVertical = true
        gamesCollectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .gray
    }
    
    @objc private func refresh(_ sender: Any) {
        viewModel.getGames()
    }
    
    
    private func configureNotFoundLabel(){
        notFoundLabel.textAlignment = .center
        notFoundLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        notFoundLabel.textColor = .label
        notFoundLabel.numberOfLines = 0
        notFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        notFoundLabel.text = "Sorry, we couldn't find your game :("
        view.addSubview(notFoundLabel)
        NSLayoutConstraint.activate([
            notFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notFoundLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            notFoundLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            notFoundLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notFoundLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        notFoundLabel.isHidden = true
    }
    
    
    private func configureSearchBar(){
        searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        setDoneOnKeyboard()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    
    //MARK: - Not Found
    func showNotFound(){
        gamesCollectionView.isHidden = true
        notFoundLabel.isHidden = false
    }
    func showGames(){
        gamesCollectionView.isHidden = false
        notFoundLabel.isHidden = true
    }

}
//MARK: - Collection View
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching{
            return viewModel.filteredGameList?.count ?? 0
        }
        
        return (viewModel.filteredGameList?.count ?? 3)-3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCellCollectionViewCell.reuseID, for: indexPath) as! GamesCellCollectionViewCell
        let game : GamesModel!
        if isSearching {
            game = viewModel.filteredGameList?[indexPath.row]
        }else{
            game = viewModel.filteredGameList?[indexPath.row+3]
        }
        cell.set(game: game)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if isSearching {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GameHeader.gameHeaderIdentifier, for: indexPath) as! GameHeader
        var games = [GamesModel?]()
        for i in 0...2 {
            games.append(viewModel.filteredGameList?[i])
        }
        header.set(games: games)
        header.delegate = self
        return header
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if isSearching {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: view.frame.width, height: view.frame.height/3)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var selectedGame:GamesModel!
        if isSearching {
            selectedGame = viewModel.filteredGameList?[indexPath.row]
        }else{
            selectedGame = viewModel.filteredGameList?[indexPath.row+3]
        }
        
        let vc = GameDetailsViewController(gameId: selectedGame?.id ?? 0,rating: selectedGame.rating ?? 0.0 )
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.searchBar.inputAccessoryView = keyboardToolbar
    }

    @objc func dismissKeyboard() {
        self.searchBar.endEditing(true)
    }
    
    
    
}
//MARK: - Search Bar
extension HomeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            isSearching = true
            viewModel.searchTask(searchText)
        }
        else{
            isSearching = false
            viewModel.searchTask("")
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
}
//MARK: - ViewModel Delegate
extension HomeViewController:HomeViewModelDelegate{
    func loading() {
        showLoadingView()
    }
    func success() {
        DispatchQueue.main.async {
            
            self.dismissLoadingView()
            self.showGames()
            self.gamesCollectionView.reloadData()
            self.refreshControl.endRefreshing()
            }
        
    }
    func error(error: ErrorTypes) {
        DispatchQueue.main.async {
            self.dismissLoadingView()
            let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert,animated: true)
        }
    }
    func searchUpdate() {
        if viewModel.filteredGameList?.count ?? 0 == 0 {
            showNotFound()
        }else{
            showGames()
        }
        gamesCollectionView.reloadData()
    }
}
//MARK: - Header Protocol
extension HomeViewController:GameHeaderDelegate{
    func didSelectGame(game: GamesModel?) {
        let vc = GameDetailsViewController(gameId: game?.id ?? 0,rating: game?.rating ?? 0.0 )
        self.navigationController?.pushViewController(vc, animated: true)
        
    
    }
}
