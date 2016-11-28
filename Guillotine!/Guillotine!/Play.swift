

import Foundation

class Play {
    var cards: [Card]
    
    init(cardsToPlay: [Card]) {
        self.cards = cardsToPlay
    }
    
    func isPlayableOn(previousPlay: Play) -> Bool {
        
    }
    
    func isValidPlay() -> Bool {
        switch cards.count {
        case 1:
            return true
        case 2:
            return allCardsEqual()
        case 3:
            if allCardsEqual() {
                return true
            } else {
                return isRun()
            }
        default:
            if isGuillotine() {
                return true
            } else {
                return isRun()
            }
        }
    }
    
    private func allCardsEqual() -> Bool {
        var prev = cards[0]
        for index in 1..cards.count {
            if prev == cards[index] {
                prev == cards[index]
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
        for index in 1..cards.count {
            if cards[index].rank != cards[index - 1].rank + 1 {
                return false
            }
        }
        return true
    }
    
    
    func isGuillotine -> Bool {
        if cards.count == 4 {
            return allCardsEqual()
        } else {
            if cards.count >= 6 && cards.count % 2 == 0 {
                cards.sort()
                for index in 1..cards.count {
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
