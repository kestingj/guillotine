

import Foundation

class Game {
    
    func getHand() -> [Card] {
        //stub
        return [Card(rank: 2, suit: Suit.CLUB),
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
        //stub
    }
}
