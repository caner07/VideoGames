//
//  GameDetailsViewModel.swift
//  VideoGames
//
//  Created by Caner on 24.10.2021.
//

import Foundation

protocol GameDetailsViewModelDelegate{
    func loading()
    func success()
    func error(error:ErrorTypes)
}

class GameDetailsViewModel{
    var gameId:Int?
    var gameDetails:GameDetailsModel?
    var delegate:GameDetailsViewModelDelegate?
    func getGameDetails(){
        delegate?.loading()
        NetworkManager.shared.getGameDetails(gameId: gameId ?? 0) { result in
            switch(result){
            case .success(let response):
                self.gameDetails = response
                self.delegate?.success()
            case .failure(let error):
                self.delegate?.error(error: error)
            }
        }
    }
}
