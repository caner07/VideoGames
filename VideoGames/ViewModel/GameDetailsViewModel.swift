//
//  GameDetailsViewModel.swift
//  VideoGames
//
//  Created by Caner on 24.10.2021.
//

import Foundation
import CoreData
import Firebase
protocol GameDetailsViewModelDelegate{
    func loading()
    func success()
    func error(error:ErrorTypes)
    func addedToFavorites()
}

class GameDetailsViewModel{
    var gameId:Int?
    var rating:Double?
    var gameDetails:GameDetailsModel?
    var delegate:GameDetailsViewModelDelegate?
    var gameAtCoreData:Game?
    
    func getGameDetails(){
        delegate?.loading()
        NetworkManager.shared.getGameDetails(gameId: gameId ?? 0) { result in
            switch(result){
            case .success(let response):
                self.gameDetails = response
                self.delegate?.success()
                self.sendViewingEvent()
            case .failure(let error):
                self.delegate?.error(error: error)
            }
        }
    }
    func isFavorite(context:NSManagedObjectContext) -> Bool {
        let request : NSFetchRequest<Game> = Game.fetchRequest()
        do{
            let gameList = try context.fetch(request)
            for game in gameList {
                if game.id == self.gameId ?? 0 {
                    self.gameAtCoreData = game
                    self.delegate?.addedToFavorites()
                    return true
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        return false
    }
    func deleteFromFavorites(context:NSManagedObjectContext){
        if let game = gameAtCoreData{
            context.delete(game)
        }
        
    }
    
    func addToFavorites(_ context:NSManagedObjectContext){
        
        let item = Game(context: context)
        item.id = Int32(gameId ?? 0)
        item.name = gameDetails?.name
        item.released = gameDetails?.released
        item.imageUrl = gameDetails?.imageUrl
        item.rating = rating ?? 0.0
        do{
            try context.save()
            sendAddedToFavoritesEvent()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func sendViewingEvent(){
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(gameId!)",
            AnalyticsParameterItemName: gameDetails?.name!,
            AnalyticsParameterContentType: "cont",
        ])
        print("send")
    }
    func sendAddedToFavoritesEvent(){
        Analytics.logEvent("addedToFavorites", parameters: [
            AnalyticsParameterItemID: "id-\(gameId!)",
            AnalyticsParameterItemName: gameDetails?.name!,
            AnalyticsParameterContentType: "cont"
        ])
    }
    
    
}
