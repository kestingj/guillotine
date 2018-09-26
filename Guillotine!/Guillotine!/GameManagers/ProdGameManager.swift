//
//  File.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/19/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import Foundation

class ProdGameManager : GameManager {
    
    static let shared = ProdGameManager()
    
    var games: [String: Game]
    let loadBalancer: LoadBalancer
    
    public init() {
        games = [String: Game]()
        self.loadBalancer = LoadBalancer(playerId: "playerId") //TODO get cached playerId
    }
    
    func getGameInformation(gameId: String) -> Game {
        return games[gameId]!
    }
    
    func listGames() -> [String] {
        return Array(games.keys)
    }
    
    func fetchAndUpdateAllGames() {
        let gameMetadataList = self.loadBalancer.getAllGames()
        gameMetadataList.forEach { (gameMetadata: GameMetadata) in
            updateGame(gameId: gameMetadata.gameId, hostName: gameMetadata.hostName, playerIds: gameMetadata.playerIds)
        }
    }
    
    func updateGame(gameId: String) {
        let game = self.games[gameId]!
        updateGame(gameId: gameId, hostName: game.hostName, playerIds: game.playerIds)
    }
    
    func updateGame(gameId: String, hostName: String, playerIds: [String]) {
        let backend = Backend(hostName: hostName)
        let updatedGame = backend.getPlayerState(gameId: gameId, playerId: "playerId", playerIds: playerIds)
        self.games[gameId] = updatedGame
    }
    
    func startNewGame(playerIds: [String]) {
        let gameMetadata = self.loadBalancer.startNewGame(playerIds: playerIds)
        updateGame(gameId: gameMetadata.gameId, hostName: gameMetadata.hostName, playerIds: gameMetadata.playerIds)
    }
    
    func playHand(play: Play, gameId: String) {
        let hostName = self.games[gameId]!.hostName
        let backend = Backend(hostName: hostName)
        backend.submitPlay(play: play, gameId:gameId)
    }
}
