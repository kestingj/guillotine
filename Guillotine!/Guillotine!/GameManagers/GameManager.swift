//
//  GameManager.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/25/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import Foundation

protocol GameManager {
    
    func getGameInformation(gameId: String) -> Game
    
    func listGames() -> [String]
    
    func fetchAndUpdateAllGames()
    
    // TODO: return true iff game was actually updated
    func updateGame(gameId: String)
    
    func updateGame(gameId: String, hostName: String, playerIds: [String])
    
    func startNewGame(playerIds: [String])
    
    func playHand(play: Play, gameId: String)
}
