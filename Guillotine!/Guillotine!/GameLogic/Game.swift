

import Foundation

class Game {
    
    var gameId: String
    var playerIds: [String]
    var turn: String
    var previousPlays: [Play]
    var playersToCardsInHand: [String:Int]
    var hand: [Card]
    var hostName: String
    
    init(
        gameId: String,
        playerIds: [String],
        turn: String,
        previousPlays: [Play],
        playersToCardsInHand: [String:Int],
        hand: [Card],
        hostName: String
    ) {
        self.gameId = gameId
        self.playerIds = playerIds
        self.turn = turn
        self.previousPlays = previousPlays
        self.playersToCardsInHand = playersToCardsInHand
        self.hand = hand
        self.hostName = hostName
    }
    
    func getHand() -> [Card] {
        //stub
        return hand
    }
    
    func getPreviousPlay() -> [Card] {
        if previousPlays.isEmpty {
            return [Card]()
        } else {
            return previousPlays[previousPlays.count - 1].cards
        }
    }
    
    func playHand(play: Play) {
        for card in play.cards {
            let index = self.hand.index(of: card)!
            self.hand.remove(at: index)
        }
        let playerId = self.playerIds[0]
        
        self.playersToCardsInHand[playerId] = self.playersToCardsInHand[playerId]! - play.cards.count
        
        let playerIndex = self.playerIds.index(of: playerId)!
        self.turn = self.playerIds[(playerIndex + 1) % self.playerIds.count]
        
        previousPlays.append(play)
    }
}
