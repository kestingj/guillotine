//
//  GameManagerProvider.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/25/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import Foundation

class GameManagerProvider {
    private static let PROD_MANAGER = false
    private static var shared: GameManager? = nil
    
    static func getShared() -> GameManager {
        if (shared == nil) {
            if (PROD_MANAGER) {
                shared = ProdGameManager()
            } else {
                shared = TestGameManager()
                
            }
            populateGameManager()
        }
        
        return shared!
    }
    
    static func populateGameManager() {
        shared?.startNewGame(playerIds: ["Joseph", "Micha", "Nick", "Payton"])
        shared?.startNewGame(playerIds: ["Joseph", "Alex", "Eli", "Austin"])
    }
}
