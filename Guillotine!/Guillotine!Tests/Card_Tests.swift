

import XCTest
@testable import GuillotineApp

class Card_Tests: XCTestCase {
    
    func testDescription() {
        let aceOfDiamonds = Card(rank: 14, suit: Suit.DIAMOND)
        assert(aceOfDiamonds.description == "ace_of_diamonds")
        
        let kingOfClubs = Card(rank: 13, suit: Suit.CLUB)
        assert(kingOfClubs.description == "king_of_clubs")
        
        let queenOfHearts = Card(rank: 12, suit: Suit.HEART)
        assert(queenOfHearts.description == "queen_of_hearts")
        
        let jackOfSpades = Card(rank: 11, suit: Suit.SPADE)
        assert(jackOfSpades.description == "jack_of_spades")
        
        let twoOfSpades = Card(rank: 2, suit: Suit.SPADE)
        assert(twoOfSpades.description == "2_of_spades")
    }
    
    func testSuitComparison() {
        let lesserSuit = Card(rank: 2, suit: Suit.SPADE)
        let greaterSuit = Card(rank: 2, suit: Suit.CLUB)
        
        assert(lesserSuit < greaterSuit)
        assert(greaterSuit > lesserSuit)
    }
    
    func testRankComparison() {
        let lesserRank = Card(rank: 10, suit: Suit.SPADE)
        let greaterRank = Card(rank: 11, suit: Suit.SPADE)
        
        assert(lesserRank < greaterRank)
        assert(greaterRank > lesserRank)
        
    }
}
