//
//  GameDetailsModel.swift
//  VideoGames
//
//  Created by Caner on 24.10.2021.
//

import Foundation

struct GameDetailsModel:Codable{
    enum CodingKeys:String,CodingKey{
        case name
        case description
        case metacritic
        case released
        case imageUrl = "background_image"
    }
    
    let name:String?
    let description:String?
    let metacritic:Int?
    let released:String?
    let imageUrl:String?
}
