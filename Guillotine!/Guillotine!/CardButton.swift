

import Foundation
import UIKit

class CardButton: UIButton {
    
    var card: Card
    
    convenience init(card: Card) {
        self.init(frame: .infinite)
        self.card = card
    }
    
    override init(frame: CGRect) {
        // set myValue before super.init is called
        self.card = Card(rank: 2, suit: Suit.SPADE)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.card = Card(rank: 2, suit: Suit.SPADE)
        super.init(coder: aDecoder)
    }
}
