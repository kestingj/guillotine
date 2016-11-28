

import Foundation

enum Suit: Int, Comparable {
    case SPADE, CLUB, DIAMOND, HEART
    
    static func < (a: Suit, b: Suit) -> Bool {
        return a.rawValue < b.rawValue
    }
    
    
}
