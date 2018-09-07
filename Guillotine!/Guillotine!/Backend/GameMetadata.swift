//
//  GameMetadata.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/6/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import Foundation

class GameMetadata {
    var gameId: String
    var hostName: String
    var playerIds: [String]
    
    init(gameId: String, hostName: String, playerIds: [String]) {
        self.gameId = gameId
        self.hostName = hostName
        self.playerIds = playerIds
    }
}
