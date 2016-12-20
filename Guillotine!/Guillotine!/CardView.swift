
import Foundation
import UIKit

class CardView : UIView {
    
    var image: UIImage
    var card: Card
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(card: Card) {
        self.card = card
        self.image = fetchImage(inputCard: card)
    }
    
    private func fetchImage(inputCard: Card) -> UIImage {
        return UIImage()
    }
    
}
