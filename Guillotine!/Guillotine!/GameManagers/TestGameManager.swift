//
//  TestGameManager.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/25/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import Foundation

class TestGameManager: GameManager {
    
    
    private static let PLAYER_ID = "Arnold"
    private static let TEST_PLAYER_IDS = [PLAYER_ID, "Alex", "Eli", "Marcel"]
    
    var games: [String: Game]
    var loadBalancerMap: [String: GameMetadata]
    
    public init() {
        self.games = [String: Game]()
        self.loadBalancerMap = [String: GameMetadata]()
    }
    
    func getGameInformation(gameId: String) -> Game {
        return self.games[gameId]!
    }
    
    func listGames() -> [String] {
        return Array(self.games.keys)
    }
    
    func fetchAndUpdateAllGames() {
        for gameId in games.keys {
            updateGame(gameId: gameId)
        }
    }
    
    func updateGame(gameId: String) {
        let game = self.games[gameId]!
        if (game.turn != TestGameManager.PLAYER_ID) {
            playHandForComputer(game: game)
        }
    }
    
    func updateGame(gameId: String, hostName: String, playerIds: [String]) {
        updateGame(gameId: gameId)
    }
    
    func startNewGame(playerIds: [String]) {
        let gameId = UUID.init().uuidString
        loadBalancerMap[gameId] = GameMetadata(gameId: gameId, hostName: "hostName", playerIds: TestGameManager.TEST_PLAYER_IDS)
    }
    
    func playHand(play: Play, gameId: String) {
        self.games[gameId]!.playHand(play: play)
    }
    
    private func playHandForComputer(game: Game) {
        let turn = game.turn
        game.previousPlays.append(Play(cardsToPlay: [Card(rank: 2, suit: Suit.SPADE)]))
        game.playersToCardsInHand[turn] = game.playersToCardsInHand[turn]! - 1
        let turnIndex = game.playerIds.index(of: turn)!
        game.turn = game.playerIds[(turnIndex + 1) % game.playerIds.count]
    }
}