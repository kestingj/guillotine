

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
    
    static let instance = Game(gameId: "gameId", playerIds: ["jim", "jimmy", "joe"], turn: "joe", previousPlays: [], playersToCardsInHand: ["jim": 13, "jimmy":12, "joe": 3], hand: [], hostName: "localhost")
    
    func getHand() -> [Card] {
        //stub
        return [Card(rank: 2, suit: Suit.SPADE),
                Card(rank: 2, suit: Suit.SPADE),
                Card(rank: 3, suit: Suit.CLUB),
                Card(rank: 3, suit: Suit.SPADE),
                Card(rank: 4, suit: Suit.CLUB),
                Card(rank: 4, suit: Suit.SPADE),
                Card(rank: 7, suit: Suit.SPADE),
                Card(rank: 7, suit: Suit.DIAMOND),
                Card(rank: 7, suit: Suit.CLUB),
                Card(rank: 13, suit: Suit.CLUB),
                Card(rank: 13, suit: Suit.HEART),
                Card(rank: 12, suit: Suit.CLUB),
                Card(rank: 11, suit: Suit.CLUB)]
    }
    
    func getPreviousPlay() -> [Card] {
        return [Card(rank: 2, suit: Suit.HEART),
                Card(rank: 2, suit: Suit.DIAMOND)]
    }
}
