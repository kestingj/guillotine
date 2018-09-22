//
//  GameCell.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/6/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    var game: Optional<String>
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.game = Optional.none
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.game = Optional.none
        super.init(coder: aDecoder)
        
        print ("CODER CONSTRUCTOR")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setColor() {
        self.backgroundColor = UIColor.blue
    }
    
    func setGame(game: Game) {
        self.game = Optional.some(game.gameId)
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.contentMode = .scaleToFill
        self.textLabel?.numberOfLines = 0
        var players = ""
        for player in game.playerIds {
            players += player + " "
        }
        self.textLabel?.text = players
    }
}
