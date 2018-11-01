

import UIKit

class ActiveGameViewController: UIViewController {

    var gameId: Optional<String> = Optional.none
    let gameManager = GameManagerProvider.getShared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let game = self.gameManager.getGameInformation(gameId: self.gameId!)
        submitPlayButton.isEnabled = false
        initializeHand(cards: game.getHand())
        // Do any additional setup after loading the view, typically from a nib.
        populatePreviousPlay(cards: game.getPreviousPlay())
        initializePlayerProfiles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var player4View: PlayerView!
    @IBOutlet weak var player3View: PlayerView!
    @IBOutlet weak var player2View: PlayerView!
    @IBOutlet weak var playContainer: CardContainer!
    @IBOutlet weak var handContainer: CardContainer!
//    @IBOutlet weak var submitPlayButton: UIButton!
    @IBOutlet weak var previousPlayContainer: CardContainer!
    
    @IBOutlet weak var submitPlayButton: UIButton!
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
            button.addTarget(self, action: #selector(ActiveGameViewController.alterCardLocation(_:)), for: .touchUpInside)
            handContainer.addCard(card: button)
        }
    }
    
    @IBAction func playCards(_ sender: Any) {
        self.gameManager.playHand(play: playContainer.getPlay(), gameId: self.gameId!)
        updateContainers()
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
    
    func setGame(gameId: String) {
        self.gameId = Optional.some(gameId)
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        print(self.gameId!)
        self.gameManager.updateGame(gameId: self.gameId!)
        updateContainers()
        updateHandCounts()
    }
    
    func updateContainers() {
        playContainer.clear()
        previousPlayContainer.clear()
        let game = self.gameManager.getGameInformation(gameId: self.gameId!)
        populatePreviousPlay(cards: game.getPreviousPlay())
        getPlayerViewForPlayer(player: game.turn).boldPlayer()
        for playerId in game.playerIds {
            if (playerId != "Joseph" && playerId != game.turn) {
                getPlayerViewForPlayer(player: playerId).unboldPlayer()
            }
        }
    }
    
    func initializePlayerProfiles() {
        let game = self.gameManager.getGameInformation(gameId: self.gameId!)
        let player2 = getPlayerAtIndex(index: 2)
        player2View.setPlayer(playerId: player2, handCount: game.playersToCardsInHand[player2]!)
        let player3 = getPlayerAtIndex(index: 3)
        player3View.setPlayer(playerId: player3, handCount: game.playersToCardsInHand[player3]!)
        let player4 = getPlayerAtIndex(index: 4)
        player4View.setPlayer(playerId: player4, handCount: game.playersToCardsInHand[player4]!)
    }
    
    func updateHandCounts() {
        let game = self.gameManager.getGameInformation(gameId: self.gameId!)
        print (game.playersToCardsInHand)
        let player2 = getPlayerAtIndex(index: 2)
        player2View.setCount(handCount: game.playersToCardsInHand[player2]!)
        let player3 = getPlayerAtIndex(index: 3)
        player3View.setCount(handCount: game.playersToCardsInHand[player3]!)
        let player4 = getPlayerAtIndex(index: 4)
        player4View.setCount(handCount: game.playersToCardsInHand[player4]!)
    }
    
    // Indices: 2, 3, 4
    private func getPlayerAtIndex(index: Int) -> String {
        let game = self.gameManager.getGameInformation(gameId: self.gameId!)
        let arrayIndex = index - 1
        let selfIndex = game.playerIds.index(of: "Joseph")!
        let playerIndex = (selfIndex + arrayIndex) % game.playerIds.count
        return game.playerIds[playerIndex]
    }
    
    private func getPlayerViewForPlayer(player: String) -> PlayerView {
        let game = self.gameManager.getGameInformation(gameId: self.gameId!)
        let selfIndex = game.playerIds.index(of: "Joseph")!
        let playerIndex = game.playerIds.index(of: player)!
        let spacesFromSelf = (((playerIndex - selfIndex) + 4) % 4)
        if spacesFromSelf == 1 {
            return player2View
        } else if spacesFromSelf == 2 {
            return player3View
        } else { // Should check if index is 3, throw in last else clause
            return player4View
        }
    }
}

