

import Foundation

class Play {
    var cards: [Card]
    
    init(cardsToPlay: [Card]) {
        self.cards = cardsToPlay
    }
    
    func isPlayableOn(previousPlay: Play) -> Bool {
        if previousPlay.cards.count == 0 {
            return true // starting a new hand
        }
        let previousType = previousPlay.getPlayType()
        let selfType = self.getPlayType()
        if previousType == selfType {
            let otherCards = previousPlay.cards.sorted()
            let selfCards = self.cards.sorted()
            if selfType == PlayType.GUILLOTINE {
                if selfCards.count == 4 && otherCards.count > 4 {
                    return true // 4 of a kind guillotine played on a run guillotine
                } else if otherCards.count == 4 && selfCards.count > 4 {
                    return false
                } else if selfCards.count > otherCards.count {
                    return true //The longer run guillotine always wins
                } else if selfCards.count < otherCards.count {
                    return false
                }
            }
            if selfCards.last! > otherCards.last! {
                return true
            }
        } else {
            if isAbleToBeGuillotined(other: previousPlay) && self.getPlayType() == PlayType.GUILLOTINE{
                return true
            }
        }
        return false
    }
    
    private func isAbleToBeGuillotined(other: Play) -> Bool {
        let otherType = other.getPlayType()
        let firstCard = other.cards[0]
        let singleOrPair = (otherType == PlayType.SINGLE) || (otherType == PlayType.PAIR)
        let isAce = firstCard.rank == 13
        return singleOrPair && isAce
    }
    
    func isValidPlay() -> Bool {
        return getPlayType() != PlayType.NONE
    }
    
    func getPlayType() -> PlayType {
        let uniquenessVerifier = Set(cards)
        if uniquenessVerifier.count == cards.count { //All cards unique
            switch cards.count {
            case 1:
                return PlayType.SINGLE
            case 2:
                if allCardsEqual() {
                    return PlayType.PAIR
                }
            case 3:
                if allCardsEqual() {
                    return PlayType.TRIPLE
                } else {
                    if isRun() {
                        return PlayType.RUN
                    }
                }
            default:
                if isGuillotine() {
                    return PlayType.GUILLOTINE
                } else {
                    if isRun() {
                        return PlayType.RUN
                    }
                }
            }
        }
        return PlayType.NONE
    }
    
    private func allCardsEqual() -> Bool {
        var prev = cards[0]
        for index in 1..<cards.count {
            if prev.rank == cards[index].rank {
                prev = cards[index]
            } else {
                return false
            }
        }
        return true
    }
    
    private func isRun() -> Bool {
        if cards.count < 3 {
            return false
        }
        cards.sort()
        for index in 1..<cards.count {
            if cards[index].rank != cards[index - 1].rank + 1 {
                return false
            }
        }
        return true
    }
    
    func isGuillotine() -> Bool {
        if cards.count == 4 {
            return allCardsEqual()
        } else {
            if cards.count >= 6 && cards.count % 2 == 0 {
                cards.sort()
                for index in 1..<cards.count {
                    if index % 2 == 0 {
                        if cards[index].rank != cards[index - 1].rank + 1 {
                            return false
                        }
                    } else {
                        if cards[index].rank != cards[index - 1].rank {
                            return false
                        }
                    }
                }
                return true
            }
            return false
        }
    }
}
