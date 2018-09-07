//
//  LoadBalancer.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/6/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import Foundation
import Alamofire

class LoadBalancer {
    let urlBase = "http://127.0.0.1:25000"
    
    let playerId:String
    
    init(playerId:String) {
        self.playerId = playerId
    }
    
    func getAllGames() -> [GameMetadata] {
        let url = urlBase + "/players/" + playerId + "/games"
        
        let request = Alamofire.request(url, method: .get)
        
        var games: [GameMetadata] = []
        
        request.responseJSON { responseData in
            if let result = responseData.result.value {
                let JSON = result as! NSDictionary
                let gameArray = JSON.object(forKey: "games") as! [NSDictionary]
                for game in gameArray {
                    let gameId = game.object(forKey: "gameId") as! String
                    let playerIds = game.object(forKey: "playerIds") as! [String]
                    let hostName = game.object(forKey: "hostName") as! String
                    
                    games.append(GameMetadata(gameId: gameId, hostName: hostName, playerIds: playerIds))
                }
            }
        }
        
        return games
    }
    
    func startNewGame(playerIds: [String]) -> GameMetadata {
        let url = urlBase + "/games"
        let parameters: [String: AnyObject] = ["playerIds": playerIds as AnyObject]
        let request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        var game: GameMetadata
        
        request.responseJSON { responseData in
            if let result = responseData.result.value {
                let JSON = result as! NSDictionary
                let gameId = JSON.object(forKey: "gameId") as! String
                let hostName = JSON.object(forKey: "hostName") as! String
                game = GameMetadata(gameId: gameId, hostName: hostName, playerIds: playerIds)
            }
        }
        
        return game
    }
}
