

import Foundation
import Alamofire

class Backend {
    
    let urlBase = "http://127.0.0.1:20001"
    let playerId = "playerId1"
    var hostName: String
    
    
    init(hostName: String) {
        self.hostName = hostName
    }
    
    func submitPlay(play: Play, gameId: String) {
        var parameters: [String: AnyObject] = ["playerId": playerId as AnyObject, "gameId":gameId as AnyObject]
        var cardList = [AnyObject]()
        for card in play.cards {
            let cardDict = ["rank": card.rank, "suit":card.suit] as [String : Any]
            cardList.append(cardDict as AnyObject)
        }
        parameters["play"] = cardList as AnyObject
        
        let url = urlBase + "/games/" + gameId + "/" + playerId
        
        let request = Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
        request.responseJSON { response in
            print(response.request ?? "No request")
            print(response.response ?? "No response")
            print(response.data ?? "No data")
            print(response.error ?? "No error")
        }
    }
    
    func getPlayerState(gameId: String, playerId: String, playerIds: [String]) -> Game {
        let parameters: [String: AnyObject] = ["playerIds": playerIds as AnyObject]
        
        let url = urlBase + "/games/" + gameId + "/" + playerId
        
        let request = Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default)
        
        var game: Optional<Game> = Optional.none
        request.responseJSON { responseData in
            if let result = responseData.result.value {
                let JSON = result as! NSDictionary
                let turn = JSON.object(forKey: "turn") as! String
                let hand = JSON.object(forKey: "hand") as! [Card]
                let playerStates = JSON.object(forKey: "playerStates") as! [NSDictionary]
                var playersToCardsInHand: [String: Int] = [:]
                for playerState in playerStates {
                    playersToCardsInHand[playerState.object(forKey: "playerId") as! String] = playerState.object(forKey: "cardsInHand") as? Int
                }
                
                let previousPlays = JSON.object(forKey: "previousPlays") as! [Play]
                
                game = Optional.some(Game(gameId: gameId, playerIds: playerIds, turn: turn, previousPlays: previousPlays, playersToCardsInHand: playersToCardsInHand, hand: hand, hostName: self.hostName))
            }
        }
        return Game.instance
//        return game!
    }
    
    func startGame(players: [String], startingPlayer: String) -> String {
        let parameters: [String: AnyObject] = ["startingPlayer": startingPlayer as AnyObject, "players": players as AnyObject]
        
        let url = urlBase + "/games"
        
        let request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        print(request.description)
        
        var gameId = "none"
        request.responseJSON { responseData in
            print(responseData)
            gameId = responseData.description
        }
        
        return gameId
    }
    
    // Unnecessary, solely for testing 
    func testGet() {
        let url = urlBase + "/games"
        
        let request = Alamofire.request(url, method: .get)
        print(request.description)
    
        
        request.response { response in
            print(response.request ?? "No request")
            print(response.response ?? "No response")
            print(response.data ?? "No data")
            print(response.error ?? "No error")
        }
    }
}
