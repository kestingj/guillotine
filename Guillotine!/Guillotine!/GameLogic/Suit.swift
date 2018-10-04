

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

extension Suit {
    static var array: [Suit] {
        var a: [Suit] = []
        switch Suit.SPADE {
        case .SPADE: a.append(.SPADE); fallthrough
        case .CLUB: a.append(.CLUB); fallthrough
        case .DIAMOND: a.append(.DIAMOND); fallthrough
        case .HEART: a.append(.HEART);
        }
        return a
    }
}
