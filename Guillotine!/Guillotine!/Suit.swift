

import Foundation

enum Suit: Int, Comparable {
    case SPADE
    case CLUB
    case DIAMOND
    case HEART
    
    static func < (a: Suit, b: Suit) -> Bool {
        return a.rawValue < b.rawValue
    }
}
