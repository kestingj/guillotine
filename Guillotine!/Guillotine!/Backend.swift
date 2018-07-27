

import Foundation
import Alamofire

class Backend {
    
    let url = "localhost:20000"
    let playerId = "playerId1"
    
    func submitPlay(play: Play, gameId: String) {
        var parameters: [String: AnyObject] = ["playerId": playerId as AnyObject, "gameId":gameId as AnyObject]
        var cardList = [AnyObject]()
        for card in play.cards {
            let cardDict = ["rank": card.rank, "suit":card.suit] as [String : Any]
            cardList.append(cardDict as AnyObject)
        }
        parameters["play"] = cardList as AnyObject
        
        let request = Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
        request.responseJSON { response in
            print(response.request ?? "No request")
            print(response.response ?? "No response")
            print(response.data ?? "No data")
            print(response.error ?? "No error")
        }
    }
    
    func startGame(players: [String]) -> String {
        // returns the game id of the new game
        return ""
    }
}
