

import XCTest
@testable import GuillotineApp

class Play_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRunPlayValid() {
        let shortRun = getRun(startRank: 2, length: 2, suit: Suit.DIAMOND)
        XCTAssertFalse(shortRun.isValidPlay())
        for i in 3...14 {
            let run = getRun(startRank: 2, length: i, suit: Suit.DIAMOND)
            assertValidPlay(play: run, type: PlayType.RUN)
        }
    }
    
    func testSingleCardValid() {
        for i in 2...14 {
            let play = Play(cardsToPlay: [Card(rank: i, suit: Suit.SPADE)])
            assertValidPlay(play: play, type: PlayType.SINGLE)
        }
    }
    
    func testPairPlayValid() {
        for i in 2...14 {
            let play = getPair(rank: i, suits: [Suit.CLUB, Suit.DIAMOND])
            assertValidPlay(play: play, type: PlayType.PAIR)
        }
    
    }
    
    func testTriplePlayValid() {
        for i in 2...14 {
            let play = getTriple(rank: i)
            assertValidPlay(play: play, type: PlayType.TRIPLE)
        }
    }
    
    func testRunGuillotine() {
        for i in 1...6 {
            let play = getRunGuillotine(startRank: 2, numberOfPairs: i, suits: [Suit.CLUB, Suit.DIAMOND])
            if i < 3 {
                XCTAssertFalse(play.isGuillotine())
            } else {
                XCTAssertTrue(play.isGuillotine())
                assertValidPlay(play: play, type: PlayType.GUILLOTINE)
            }
        }
    }
    
    func testFourOfAKindGuillotine() {
        for i in 2...14 {
            let play = getFourOfAKindGuillotine(rank: i)
            XCTAssertTrue(play.isGuillotine())
            assertValidPlay(play: play, type: PlayType.GUILLOTINE)
        }
    }
    
    func testInvalidHands() {
        var invalidPlay = [Card(rank: 2, suit: Suit.SPADE), Card(rank: 4, suit: Suit.SPADE)]
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
        invalidPlay.append(Card(rank: 4, suit: Suit.CLUB))
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
        invalidPlay.append(Card(rank: 2, suit: Suit.CLUB))
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
        invalidPlay.append(Card(rank: 14, suit: Suit.CLUB))
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
    }
    
    func testIdenticalCardsInvalidPlay() {
        let invalidPlay = [Card(rank: 2, suit: Suit.SPADE), Card(rank: 2, suit: Suit.SPADE)]
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isValidPlay())
    }
    
    func testRunPlayable() {
        let lower = getRun(startRank: 4, length: 5, suit: Suit.CLUB)
        let higher = getRun(startRank: 5, length: 5, suit: Suit.CLUB)
        assertPlayable(lower: lower, higher: higher)
        
        let suitTiebreakerLower = getRun(startRank: 4, length: 5, suit: Suit.CLUB)
        let suitTiebreakerHigher = getRun(startRank: 4, length: 5, suit: Suit.HEART)
        assertPlayable(lower: suitTiebreakerLower, higher: suitTiebreakerHigher)
        
        let differentSizeRun = getRun(startRank: 2, length: 7, suit: Suit.CLUB)
        XCTAssertFalse(differentSizeRun.isPlayableOn(previousPlay: higher))
    }
    
    func testSingleCardPlayable() {
        let lower = Play(cardsToPlay: [Card(rank: 5, suit: Suit.CLUB)])
        let higher = Play(cardsToPlay: [Card(rank: 7, suit: Suit.CLUB)])
        assertPlayable(lower: lower, higher: higher)
        
        let suitTiebreakerLower = Play(cardsToPlay: [Card(rank: 5, suit: Suit.CLUB)])
        let suitTiebreakerHigher = Play(cardsToPlay: [Card(rank: 5, suit: Suit.HEART)])
        assertPlayable(lower: suitTiebreakerLower, higher: suitTiebreakerHigher)
    }
    
    func testPairPlayable() {
        let lower = getPair(rank: 4, suits: [Suit.CLUB, Suit.DIAMOND])
        let higher = getPair(rank: 5, suits: [Suit.CLUB, Suit.DIAMOND])
        assertPlayable(lower: lower, higher: higher)
        
        let suitTiebreakerLower = getPair(rank: 4, suits: [Suit.CLUB, Suit.DIAMOND])
        let suitTiebreakerHigher = getPair(rank: 4, suits: [Suit.SPADE, Suit.HEART])
        assertPlayable(lower: suitTiebreakerLower, higher: suitTiebreakerHigher)
    }
    
    func testTriplePlayable() {
        let lower = getTriple(rank: 4)
        let higher = getTriple(rank: 5)
        assertPlayable(lower: lower, higher: higher)
    }
    
    func testRunGuillotinePlayable() {
        let oneAce = Play(cardsToPlay: [Card(rank: 14, suit: Suit.HEART)])
        let pairAces = getPair(rank: 14, suits: [Suit.SPADE, Suit.CLUB])
        let tripleAces = getTriple(rank: 14)
        
        let lower = getRunGuillotine(startRank: 2, numberOfPairs: 3, suits: [Suit.CLUB, Suit.SPADE])
        let higher = getRunGuillotine(startRank: 3, numberOfPairs: 3, suits: [Suit.CLUB, Suit.SPADE])
        assertPlayable(lower: lower, higher: higher)
        assertPlayable(lower: oneAce, higher: lower)
    
        XCTAssertFalse(lower.isPlayableOn(previousPlay: tripleAces))
        assertPlayable(lower: pairAces, higher: lower)
        
        let suitTiebreakerLower = getRunGuillotine(startRank: 2, numberOfPairs: 3, suits: [Suit.CLUB, Suit.DIAMOND])
        let suitTiebreakerHigher = getRunGuillotine(startRank: 2, numberOfPairs: 3, suits: [Suit.SPADE, Suit.HEART])
        assertPlayable(lower: suitTiebreakerLower, higher: suitTiebreakerHigher)
        
        let shorter = getRunGuillotine(startRank: 6, numberOfPairs: 3, suits: [Suit.CLUB, Suit.DIAMOND])
        let longer = getRunGuillotine(startRank: 2, numberOfPairs: 4, suits: [Suit.CLUB, Suit.DIAMOND])
        assertPlayable(lower: shorter, higher: longer)
    }
    
    func testFourOfAKindGuillotinePlayable() {
        let runGuillotine = getRunGuillotine(startRank: 10, numberOfPairs: 3, suits: [Suit.CLUB, Suit.HEART])
        let oneAce = Play(cardsToPlay: [Card(rank: 14, suit: Suit.HEART)])
        let pairAces = getPair(rank: 14, suits: [Suit.SPADE, Suit.CLUB])
        let tripleAces = getTriple(rank: 14)
        let lower = getFourOfAKindGuillotine(rank: 3)
        let higher = getFourOfAKindGuillotine(rank: 6)
        assertPlayable(lower: lower, higher: higher)
        assertPlayable(lower: oneAce, higher: lower)
        assertPlayable(lower: pairAces, higher: lower)
        XCTAssertFalse(lower.isPlayableOn(previousPlay: tripleAces))
        assertPlayable(lower: runGuillotine, higher: lower)
    
    }
    
    func testPlayTypesMustMatch() {
        let plays = getPlayOfEachType()
        for i in 0..<plays.count {
            for j in 0..<plays.count {
                if i != j {
                    XCTAssertFalse(plays[i].isPlayableOn(previousPlay: plays[j]))
                }
            }
        }
    }
    
    func testEveryValidPlayStartable() {
        var plays = getPlayOfEachType()
        let start = Play(cardsToPlay: [Card]())
        plays.append(getFourOfAKindGuillotine(rank: 9))
        for i in 0..<plays.count {
            assertPlayable(lower: start, higher: plays[i])
        }
    }
    
    func testInvalidPlayNotStartable() {
        let empty = Play(cardsToPlay: [Card]())
        let invalidPlay = [Card(rank: 2, suit: Suit.SPADE), Card(rank: 4, suit: Suit.SPADE)]
        XCTAssertFalse(Play(cardsToPlay: invalidPlay).isPlayableOn(previousPlay: empty))
    }
    
    func getPlayOfEachType() -> [Play] {
        var plays = [Play]()
        plays.append(Play(cardsToPlay: [Card(rank: 6, suit: Suit.SPADE)]))
        plays.append(getPair(rank: 4, suits: [Suit.CLUB, Suit.DIAMOND]))
        plays.append(getTriple(rank: 7))
        plays.append(getRunGuillotine(startRank: 10, numberOfPairs: 3, suits: [Suit.CLUB, Suit.DIAMOND]))
        plays.append(getRun(startRank: 2, length: 4, suit: Suit.HEART))
        return plays
    }
    
    func assertPlayable(lower: Play, higher: Play) {
        XCTAssertTrue(higher.isPlayableOn(previousPlay: lower))
        XCTAssertFalse(lower.isPlayableOn(previousPlay: higher))
    }
    
    func assertValidPlay(play: Play, type: PlayType) {
        XCTAssert(play.getPlayType() == type)
        XCTAssert(play.isValidPlay())
    }
    
    
    
    func getRunGuillotine(startRank: Int, numberOfPairs: Int, suits: [Suit]) -> Play {
        var cards = [Card]()
        for i in 0..<numberOfPairs {
            let rank = startRank + i
            let pair = [Card(rank: rank, suit: suits[0]), Card(rank: rank, suit: suits[1])]
            cards.append(contentsOf: pair)
        }
        return makePlay(cards: cards)
    }
    
    func getFourOfAKindGuillotine(rank: Int) -> Play {
        let cards = [Card(rank: rank, suit: Suit.DIAMOND), Card(rank: rank, suit: Suit.SPADE), Card(rank: rank, suit: Suit.CLUB), Card(rank: rank, suit: Suit.HEART)]
        return makePlay(cards: cards)
    }
    
    func getRun(startRank: Int, length: Int, suit: Suit) -> Play {
        var cards = [Card]()
        for i in 0..<length {
            cards.append(Card(rank: startRank + i, suit: suit))
        }
        return makePlay(cards: cards)
    }
    
    func getPair(rank: Int, suits: [Suit]) -> Play {
        let cards = [Card(rank: rank, suit: suits[0]), Card(rank: rank, suit: suits[1])]
        return makePlay(cards: cards)
    }
    
    func getTriple(rank: Int) -> Play {
        let cards = [Card(rank: rank, suit: Suit.CLUB), Card(rank: rank, suit: Suit.DIAMOND), Card(rank: rank, suit: Suit.SPADE)]
        return makePlay(cards: cards)
    }
    
    func makePlay(cards: [Card]) -> Play {
        return Play(cardsToPlay: shuffle(list: cards))
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
