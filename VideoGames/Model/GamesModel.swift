//
//  GamesModel.swift
//  VideoGames
//
//  Created by Caner on 23.10.2021.
//

import Foundation

struct GamesResponseModel{
    let results:[GamesModel]?
}



struct GamesModel{
    enum CodingKeys:String,CodingKey{
        case id
        case name
        case released
        case image = "background_image"
        case rating
    }
    let id:Int?
    let name:String?
    let released:String?
    let image:String?
    let rating:Double?
}
