//
//  HomeViewModel.swift
//  VideoGames
//
//  Created by Caner on 23.10.2021.
//

import Foundation

protocol HomeViewModelDelegate{
    func loading()
    func success()
    func error(error:ErrorTypes)
    func searchUpdate()
}

class HomeViewModel{
    var delegate:HomeViewModelDelegate?
    var gameList:[GamesModel]?
    var filteredGameList:[GamesModel]?
    func getGames(){
        delegate?.loading()
        NetworkManager.shared.getGames { result in
            switch(result){
            case .success(let response):
                self.gameList = response.results
                self.filteredGameList = response.results
                self.delegate?.success()
            case.failure( let error):
                self.delegate?.error(error: error)
            }
        }
    }
    func searchTask(_ searchText:String){
        filteredGameList = searchText.isEmpty ? gameList : gameList?.filter({(dataString: GamesModel) -> Bool in
                // If dataItem matches the searchText, return true to include it
            let search = dataString.name ?? ""
            return ((search.lowercased().contains(searchText.lowercased())))
            })
        
        delegate?.searchUpdate()
    }
    
}
