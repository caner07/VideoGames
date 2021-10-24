//
//  GameDetailsViewController.swift
//  VideoGames
//
//  Created by Caner on 21.10.2021.
//

import UIKit

class GameDetailsViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    var gameImage = UIImageView()
    var likeButton = UIButton()
    var releaseDateLabel = UILabel()
    var metacriticLabel = UILabel()
    var descriptionLabel = UILabel()
    var containerView = UIView()
    
    var isLiked = false
    let viewModel = GameDetailsViewModel()
    
    init(gameId:Int){
        super.init(nibName: nil, bundle: nil)
        viewModel.gameId = gameId
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configure()
        viewModel.delegate = self
        viewModel.getGameDetails()
    }
    func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
    }
    
    
    
    private func configure(){
        view.backgroundColor = .systemBackground
        
        releaseDateLabel.textAlignment = .left
        releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
        releaseDateLabel.textColor = .label
        metacriticLabel.textAlignment = .left
        metacriticLabel.font = UIFont.systemFont(ofSize: 16)
        metacriticLabel.textColor = .label
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .label
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        
        contentView.addSubview(gameImage)
        contentView.addSubview(likeButton)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(metacriticLabel)
        contentView.addSubview(descriptionLabel)
       
        gameImage.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        metacriticLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .default)
        let image = UIImage(systemName: "star", withConfiguration: config)
        likeButton.setImage(image, for: .normal)
        likeButton.tintColor = .white
        likeButton.layer.zPosition = 1
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        let padding:CGFloat = 8
       
        NSLayoutConstraint.activate([
            gameImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: padding),
            gameImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            gameImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            gameImage.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor),
            gameImage.heightAnchor.constraint(equalToConstant: view.bounds.height/2.5),
        ])
        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: gameImage.trailingAnchor,constant: -12),
            likeButton.bottomAnchor.constraint(equalTo: gameImage.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            releaseDateLabel.topAnchor.constraint(equalTo: gameImage.bottomAnchor,constant: padding),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: padding),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -padding)
        ])
        NSLayoutConstraint.activate([
            metacriticLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: padding),
            metacriticLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: padding),
            metacriticLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -padding)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: metacriticLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: padding)
        ])
       
        
    }
    
    @objc func likeButtonTapped(){
        if isLiked {
            let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .default)
            let image = UIImage(systemName: "star", withConfiguration: config)
            likeButton.setImage(image, for: .normal)
        }else{
            let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .default)
            let image = UIImage(systemName: "star.fill", withConfiguration: config)
            likeButton.setImage(image, for: .normal)
        }
        isLiked.toggle()
    }
    
    private func updateUI(){
        guard let gameDetails = viewModel.gameDetails else {return}
        self.navigationItem.title = gameDetails.name
        
        releaseDateLabel.text = "Release Date : \(gameDetails.released ?? "")"
        metacriticLabel.text = "Metacritic Score : \(gameDetails.metacritic ?? 0)"
        descriptionLabel.text = "Game Description : \(gameDetails.description ?? "")"
        guard let url = URL(string: gameDetails.imageUrl ?? "") else{return}
        gameImage.kf.indicatorType = .activity
        gameImage.kf.setImage(with: url)
    }
    
    private func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    private func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            
        }
    }

}
extension GameDetailsViewController:GameDetailsViewModelDelegate{
    func loading() {
        showLoadingView()
    }
    
    func success() {
        DispatchQueue.main.async {
            self.dismissLoadingView()
            self.updateUI()
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
    
    
}
