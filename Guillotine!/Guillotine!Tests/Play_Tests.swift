

import XCTest
@testable import GuillotineApp

class Play_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRunPlayValid() {
        var cards = [Card(rank: 2, suit: Suit.SPADE), Card(rank: 3, suit: Suit.SPADE)]
        XCTAssertFalse(Play(cardsToPlay: cards).isValidPlay())
        for i in 4...13 {
            cards.append(Card(rank: i, suit: Suit.SPADE))
            cards = shuffle(list: cards)
            assertValidPlay(cards: cards, type: PlayType.RUN)
        }
    }
    
    func testSingleCardValid() {
        for i in 2...13 {
            let cards = [Card(rank: i, suit: Suit.SPADE)]
            assertValidPlay(cards: cards, type: PlayType.SINGLE)
        }
    }
    
    func testPairPlayValid() {
        for i in 2...13 {
            let cards = shuffle(list: getPair(rank: i))
            assertValidPlay(cards: cards, type: PlayType.PAIR)
        }
    
    }
    
    func testTriplePlayValid() {
        for i in 2...13 {
            let cards = shuffle(list: getTriple(rank: i))
            assertValidPlay(cards: cards, type: PlayType.TRIPLE)
        }
    }
    
    func testRunGuillotine() {
        var cards = getPair(rank: 2)
        XCTAssertFalse(Play(cardsToPlay: cards).isGuillotine())
        cards.append(contentsOf: getPair(rank: 3))
        cards = shuffle(list: cards)
        XCTAssertFalse(Play(cardsToPlay: cards).isGuillotine())
        for i in 4...7 {
            cards.append(contentsOf: getPair(rank: i))
            cards = shuffle(list: cards)
            XCTAssertTrue(Play(cardsToPlay: cards).isGuillotine())
            assertValidPlay(cards: cards, type: PlayType.GUILLOTINE)
        }
    }
    
    func testFourOfAKindGuillotine() {
        for i in 2...13 {
            let cards = [Card(rank: i, suit: Suit.DIAMOND), Card(rank: i, suit: Suit.SPADE), Card(rank: i, suit: Suit.CLUB), Card(rank: i, suit: Suit.HEART)]
            XCTAssertTrue(Play(cardsToPlay: cards).isGuillotine())
            assertValidPlay(cards: cards, type: PlayType.GUILLOTINE)
        }
    }
    
    func testInvalidHands() {
        var invalidPlay = [Card(rank: 2, suit: Suit.SPADE), Card(rank: 4, suit: Suit.SPADE)]
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
        invalidPlay.append(Card(rank: 4, suit: Suit.CLUB))
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
        invalidPlay.append(Card(rank: 2, suit: Suit.CLUB))
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
        invalidPlay.append(Card(rank: 13, suit: Suit.CLUB))
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
    }
    
    func testIdenticalCardsInvalidPlay() {
        let invalidPlay = [Card(rank: 2, suit: Suit.SPADE), Card(rank: 2, suit: Suit.SPADE)]
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
    }
    
    func assertValidPlay(cards: [Card], type: PlayType) {
        let play = Play(cardsToPlay: cards)
        XCTAssert(play.getPlayType() == type)
        XCTAssert(play.isValidPlay())
    }
    
    func getPair(rank: Int) -> [Card] {
        return [Card(rank: rank, suit: Suit.CLUB), Card(rank: rank, suit: Suit.DIAMOND)]
    }
    
    func getTriple(rank: Int) -> [Card] {
        return [Card(rank: rank, suit: Suit.CLUB), Card(rank: rank, suit: Suit.DIAMOND), Card(rank: rank, suit: Suit.SPADE)]
    }
    
    func shuffle(list: [Card]) -> [Card] {
        var shuffledList = [Card]()
        var viableIndices = [Int]()
        viableIndices.append(contentsOf: 0..<list.count)
        for _ in 0..<list.count {
            let rand = arc4random_uniform(UInt32(viableIndices.count))
            let index = Int(viableIndices.remove(at: Int(rand)))
            shuffledList.append(list[index])
        }
        return shuffledList
    }
}
