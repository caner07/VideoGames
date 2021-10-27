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
    var notFoundLabel = UILabel()
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
        configureNotFoundLabel()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Anasayfadan favorilere ekleyip buraya geçiş yapıldığında her seferinde yenilenmesi lazım o yüzden will appear içinde sayfayı yeniliyoruz.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        viewModel.getFavoriteGames(managedContext)
        
        // Favoriler ekranında search edip bir oyun seçilir ve geri dönülürse tekrar bütün oyunlar çağırılıyor o yüzden search işlemini tekrar yaptırmamız lazım.
        if let searchText = self.searchBar.text{
            if !searchText.isEmpty {
                viewModel.searchInFavorites(managedContext, searchText)
            }
        }
        
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
    func showNotFound(){
        gamesCollectionView.isHidden = true
        notFoundLabel.isHidden = false
    }
    func showGames(){
        gamesCollectionView.isHidden = false
        notFoundLabel.isHidden = true
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
        let destvc = GameDetailsViewController(gameId: Int(selectedGame?.id ?? 0),rating: selectedGame?.rating ?? 0.0 )
        navigationController?.pushViewController(destvc, animated: true)
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
            if self.viewModel.filteredGameList?.count ?? 0 == 0 {
                self.showNotFound()
            }else{
                self.showGames()
            }
            self.gamesCollectionView.reloadData()
        }
    }
}
