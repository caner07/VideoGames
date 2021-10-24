//
//  NetworkManager.swift
//  VideoGames
//
//  Created by Caner on 23.10.2021.
//

import Foundation
import Alamofire

class NetworkManager{
    static let shared = NetworkManager() // singleton
    private let BASE_URL = "https://rawg-video-games-database.p.rapidapi.com/games"
    private let rawgKey = "48c1cb5f3f424d9386f74809eecc97af"
    private let rapidKey = "8cf3bc272cmsh15cd72b9c771892p1b2a64jsnbcda904e759d"
    
    private init() {}
    
    func getGames(completion: @escaping (Result<GamesResponseModel,ErrorTypes>)->Void ){
        let urlString = "\(BASE_URL)?key=\(rawgKey)"
        let url = URL(string: urlString)
        let headers:HTTPHeaders = ["x-rapidapi-key":rapidKey]
        AF.request(url!,method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON { response in
            
            switch response.result{
            case .success(_):
                
                if let data = response.data{
                    do{
                        let decoder = JSONDecoder()
                        let games = try decoder.decode(GamesResponseModel.self, from: data)
                        completion(Result.success(games))
                    }catch{
                        completion(Result.failure(.invalidModel))
                    }
                }else{
                    completion(Result.failure(.invalidData))
                }
                
            case .failure(_):
                completion(Result.failure(.invalidResponse))
            }
            
        }
    }
    
    func getGameDetails(gameId:Int,completion: @escaping (Result<GameDetailsModel,ErrorTypes>) -> Void ){
        let urlString = "\(BASE_URL)/\(gameId)?key=\(rawgKey)"
        let url = URL(string: urlString)
        let headers:HTTPHeaders = ["x-rapidapi-key":rapidKey]
        AF.request(url!,method: .get,encoding: JSONEncoding.default,headers: headers).responseJSON { response in
            
            switch response.result{
            case .success(_):
                if let data = response.data{
                    do{
                        let decoder = JSONDecoder()
                        let details = try decoder.decode(GameDetailsModel.self, from: data)
                        completion(Result.success(details))
                    }catch{
                        completion(Result.failure(.invalidModel))
                    }
                }else{
                    completion(Result.failure(.invalidData))
                }
                
            case .failure(_):
                completion(Result.failure(.invalidResponse))
            }
        }
    }
}
