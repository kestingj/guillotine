//
//  CardContainer.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 7/24/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import Foundation
import UIKit

class CardContainer: UIStackView {
    func getPlay() -> Play {
        
        var cards = [Card]()
        for i in 0..<arrangedSubviews.count {
            let button = arrangedSubviews[i] as! CardButton
            cards.append(button.card)
        }
        return Play(cardsToPlay: cards)
    }
    
    func addCard(card:CardButton) {
        addArrangedSubview(card)
    }
    
    func clear() {
        for view in arrangedSubviews {
            view.removeFromSuperview()
            removeArrangedSubview(view)
        }
    }
}
