

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        submitPlayButton.isEnabled = false
        let game = Game.instance
        initializeHand(cards: game.getHand())
        // Do any additional setup after loading the view, typically from a nib.
        populatePreviousPlay(cards: game.getPreviousPlay())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var playContainer: UIStackView!
    @IBOutlet weak var handContainer: UIStackView!
    @IBOutlet weak var submitPlayButton: UIButton!
    @IBOutlet weak var previousPlayContainer: UIStackView!
    
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
            let button = getCardButton(card: card)
            button.addTarget(self, action: #selector(ViewController.buttonClicked(_:)), for: .touchUpInside)
            handContainer.addArrangedSubview(button)
        }
    }
    
    @IBAction func playCards(_ sender: Any) {
        let game = Game.instance
        game.playHand(play: getPlayFromContainer(container: playContainer))
    }
    
    func getCardButton(card: Card) -> UIButton {
        let button = CardButton(card: card)
//        var imageView = UIImageView(frame: CGRect(x: 10, y: 8, width: 10, height: 10));
        let image = UIImage(named: card.description)
//        imageView.image = image
        button.setImage(image, for: UIControlState.normal)
        
        return button
    }
    
    @objc func buttonClicked(_ sender: UIButton?) {
        if sender?.superview == handContainer {
            handContainer.removeArrangedSubview(sender!)
            playContainer.addArrangedSubview(sender!)
        } else {
            handContainer.addArrangedSubview(sender!)
            playContainer.removeArrangedSubview(sender!)
        }
        let currentPlay = getPlayFromContainer(container: playContainer)
        let previousPlay = getPlayFromContainer(container: previousPlayContainer)
        if currentPlay.isPlayableOn(previousPlay: previousPlay) {
            submitPlayButton.isEnabled = true
        } else {
            submitPlayButton.isEnabled = false
        }
    }
    
    func populatePreviousPlay(cards: [Card]) {
        for i in 0..<cards.count {
            let button = getCardButton(card: cards[i])
//            button.addTarget(self, action: #selector(ViewController.buttonClicked(_:)), for: .touchUpInside)
            previousPlayContainer.addArrangedSubview(button)
        }
    }
    
    func getPlayFromContainer(container: UIStackView) -> Play {
        let views = container.arrangedSubviews
        var cards = [Card]()
        for i in 0..<views.count {
            let button = views[i] as! CardButton
            cards.append(button.card)
        }
        return Play(cardsToPlay: cards)
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

