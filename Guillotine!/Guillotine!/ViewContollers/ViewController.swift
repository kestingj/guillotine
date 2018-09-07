

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

    @IBOutlet weak var playContainer: CardContainer!
    @IBOutlet weak var handContainer: CardContainer!
    @IBOutlet weak var submitPlayButton: UIButton!
    @IBOutlet weak var previousPlayContainer: CardContainer!
    
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
            let button = CardButton(card: card)
            button.addTarget(self, action: #selector(ViewController.alterCardLocation(_:)), for: .touchUpInside)
            handContainer.addArrangedSubview(button)
        }
    }
    
    @IBAction func playCards(_ sender: Any) {
        let game = Game.instance
        game.playHand(play: playContainer.getPlay())
    }
    
    
    @objc func alterCardLocation(_ sender: UIButton?) {
        if sender?.superview == handContainer {
            handContainer.removeArrangedSubview(sender!)
            playContainer.addArrangedSubview(sender!)
        } else {
            handContainer.addArrangedSubview(sender!)
            playContainer.removeArrangedSubview(sender!)
        }
        let currentPlay = playContainer.getPlay()
        let previousPlay = previousPlayContainer.getPlay()
        if currentPlay.isPlayableOn(previousPlay: previousPlay) {
            submitPlayButton.isEnabled = true
        } else {
            submitPlayButton.isEnabled = false
        }
    }
    
    func populatePreviousPlay(cards: [Card]) {
        for i in 0..<cards.count {
            let button = CardButton(card: cards[i])
//            button.addTarget(self, action: #selector(ViewController.buttonClicked(_:)), for: .touchUpInside)
            previousPlayContainer.addCard(card: button)
        }
    }
}

