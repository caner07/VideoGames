//
//  ErrorTypes.swift
//  VideoGames
//
//  Created by Caner on 23.10.2021.
//

import Foundation

enum ErrorTypes:String,Error{
    case invalidData = "The data recieved from the server was invalid."
    case invalidResponse = "Please check your internet connection."
    case invalidModel = "The data recieved from the server wasn't match with the model."
}
