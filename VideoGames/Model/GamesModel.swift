//
//  GamesModel.swift
//  VideoGames
//
//  Created by Caner on 23.10.2021.
//

import Foundation

struct GamesResponseModel:Codable{
    let results:[GamesModel]?
}



struct GamesModel:Codable{
    enum CodingKeys:String,CodingKey{
        case id
        case name
        case released
        case imageUrl = "background_image"
        case rating
    }
    let id:Int?
    let name:String?
    let released:String?
    let imageUrl:String?
    let rating:Double?
}
