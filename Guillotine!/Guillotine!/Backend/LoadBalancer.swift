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
        
        var games: [GameMetadata]
        
        request.responseJSON { responseData in
            if let result = responseData.result.value {
                let JSON = result as! NSDictionary
                games = JSON.object(forKey: "games") as! [GameMetadata]
            }
        }
        
        return games
    }
}
