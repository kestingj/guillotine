

import Foundation

class Game {
    
    var gameId: String
    var playerIds: [String]
    var turn: String
    var previousPlays: [Play]
    var sequenceNumber: Int
    var playersToCardsInHand: [String:Int]
    var hand: [Card]
    
    init(
        gameId: String,
        playerIds: [String],
        turn: String,
        previousPlays: [Play],
        sequenceNumber: Int,
        playersToCardsInHand: [String:Int],
        hand: [Card]
    ) {
        self.gameId = gameId
        self.playerIds = playerIds
        self.turn = turn
        self.previousPlays = previousPlays
        self.sequenceNumber = sequenceNumber
        self.playersToCardsInHand = playersToCardsInHand
        self.hand = hand
    }
    
    static let instance = Game(gameId: "gameId", playerIds: ["jim", "jimmy", "joe"], turn: "joe", previousPlays: [], sequenceNumber: 1, playersToCardsInHand: ["jim": 13, "jimmy":12, "joe": 3], hand: [])
    let backend = Backend()
    
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
    
    func playHand(play: Play) {
        backend.testGet()
        print(play)
    }
    
    func getPreviousPlay() -> [Card] {
        return [Card(rank: 2, suit: Suit.HEART),
                Card(rank: 2, suit: Suit.DIAMOND)]
    }
}