

import Foundation

struct Card: Comparable, Hashable {
    var rank: Int
    var suit: Suit
    var description: String {
        var suitString: String
        switch suit {
        case .SPADE:
            suitString = "spades"
        case .HEART:
            suitString = "hearts"
        case .DIAMOND:
            suitString = "diamonds"
        default:
            suitString = "clubs"
        }
        var rankString: String
        switch rank {
        case 14:
            rankString = "ace"
        case 13:
            rankString = "king"
        case 12:
            rankString = "queen"
        case 11:
            rankString = "jack"
        default:
            rankString = rank.description
        }
        return rankString + "_of_" + suitString
    }
    
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
    
    func getImageName(card: Card) -> String {
        var suit: String
        switch card.suit {
        case .SPADE:
            suit = "spades"
        case .HEART:
            suit = "hearts"
        case .DIAMOND:
            suit = "diamonds"
        default:
            suit = "clubs"
        }
        var rank: String
        switch card.rank {
        case 14:
            rank = "ace"
        case 13:
            rank = "king"
        case 12:
            rank = "queen"
        case 11:
            rank = "jack"
        default:
            rank = card.rank.description
        }
        return rank + "_of_" + suit
    }
}

