

import Foundation

struct Card: Comparable, Hashable {
    var rank: Int
    var suit: Suit
    var hashValue: Int {
        return rank + suit.rawValue * 13
    }
    
    init(rank: Int, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
    
    static func < (a: Card, b: Card) -> Bool {
        if a.rank == b.rank {
            return a.suit < b.suit
        }
        return a.rank < b.rank
    }
    
    static func > (a: Card, b: Card) -> Bool {
        if a.rank == b.rank {
            return a.suit > b.suit
        }
        return a.rank > b.rank
    }
    
    static func == (a: Card, b: Card) -> Bool {
        return a.rank == b.rank && a.suit == b.suit
    }
}

