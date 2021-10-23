//
//  NetworkManager.swift
//  VideoGames
//
//  Created by Caner on 23.10.2021.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager() // singleton
    private let BASE_URL = "https://rawg-video-games-database.p.rapidapi.com/games"
    private let rawgKey = "48c1cb5f3f424d9386f74809eecc97af"
    private let rapidKey = "8cf3bc272cmsh15cd72b9c771892p1b2a64jsnbcda904e759d"
    private let rapidHost = "rawg-video-games-database.p.rapidapi.com"
    private init() {}
    
    func getGames(){
        let urlString = BASE_URL + "?key\(rawgKey)"
        let url = URL(string: urlString)
        
    }
}
