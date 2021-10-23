//
//  HomeViewController.swift
//  VideoGames
//
//  Created by Caner on 21.10.2021.
//

import UIKit

class HomeViewController: UIViewController {
    var searchBar:UISearchBar!
    var gamesCollectionView : UICollectionView!
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    private func configureViewController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        configureSearchBar()
        createDismissKeyboardTapGesture()
    }
    private func configureSearchBar(){
        searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Ara"
        searchBar.sizeToFit()
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func configureCollectionView(){
        
        let width =  view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let itemWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 80)
        gamesCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        gamesCollectionView.keyboardDismissMode = .onDrag
        view.addSubview(gamesCollectionView)
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.register(GamesCellCollectionViewCell.self, forCellWithReuseIdentifier: GamesCellCollectionViewCell.reuseID)
        gamesCollectionView.register(GameHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GameHeader.gameHeaderIdentifier)
    }

}
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCellCollectionViewCell.reuseID, for: indexPath) as! GamesCellCollectionViewCell
        cell.set()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if isSearching {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GameHeader.gameHeaderIdentifier, for: indexPath)
        
        
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
    
    
}
extension HomeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            isSearching = true
            gamesCollectionView.reloadData()
        }
        else{
            isSearching = false
            gamesCollectionView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
}
