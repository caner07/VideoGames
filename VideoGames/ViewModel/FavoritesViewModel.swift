//
//  FavoritesViewModel.swift
//  VideoGames
//
//  Created by Caner on 24.10.2021.
//

import Foundation
import CoreData
protocol FavoritesViewModelDelegate {
    func reload()
}
class FavoritesViewModel{
    var gameList:[Game]?
    var filteredGameList:[Game]?
    var delegate:FavoritesViewModelDelegate?
    func getFavoriteGames(_ context:NSManagedObjectContext){
        let request : NSFetchRequest<Game> = Game.fetchRequest()
        do{
            gameList = try context.fetch(request)
            filteredGameList = gameList
            delegate?.reload()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func searchInFavorites(_ context:NSManagedObjectContext, _ searchText:String){
        if searchText.isEmpty {
            filteredGameList = gameList
            delegate?.reload()
            return
        }
        let predicate = NSPredicate(format: "name contains[c] '\(searchText)'")
        let request : NSFetchRequest<Game> = Game.fetchRequest()
        request.predicate = predicate
        do{
            filteredGameList = try context.fetch(request)
            delegate?.reload()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
}
