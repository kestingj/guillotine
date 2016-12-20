

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        canPlay.isEnabled = false
        let game = Game()
        initializeHand(cards: game.getHand())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var play: UIStackView!
    @IBOutlet weak var hand: UIStackView!
    @IBOutlet weak var canPlay: UIButton!
    
    func someAction(_ sender:UITapGestureRecognizer){
        // do other task
    }
    
    //Pass in presorted array of cards
    func initializeHand(cards: [Card]) {
//        hand.autoresizesSubviews = true
//        play.autoresizesSubviews = true
//        hand.layo
        for i in 0..<cards.count {
            let card = cards[i]
            hand.addArrangedSubview(getCardButton(card: card))
        }
    }
    
    @IBAction func playCards(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "NOICE", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCardButton(card: Card) -> UIButton {
        let button = CardButton(card: card)
//        var imageView = UIImageView(frame: CGRect(x: 10, y: 8, width: 10, height: 10));
        let image = UIImage(named: card.description)
//        imageView.image = image
        button.setImage(image, for: UIControlState.normal)
        button.addTarget(self, action: #selector(ViewController.buttonClicked(_:)), for: .touchUpInside)
        return button
    }
    
    func buttonClicked(_ sender: UIButton?) {
        if sender?.superview == hand {
            hand.removeArrangedSubview(sender!)
            play.addArrangedSubview(sender!)
        } else {
            hand.addArrangedSubview(sender!)
            play.removeArrangedSubview(sender!)
        }
        if playIsViable(views: play.arrangedSubviews) {
            canPlay.isEnabled = true
        } else {
            canPlay.isEnabled = false
        }
    }
    
    func playIsViable(views: [UIView]) -> Bool {
        let previousPlay = Play(cardsToPlay: [Card]()) //Placeholder
        var cards = [Card]()
        for i in 0..<views.count {
            let button = views[i] as! CardButton
            cards.append(button.card)
        }
        return Play(cardsToPlay: cards).isPlayableOn(previousPlay: previousPlay)
    }
}

