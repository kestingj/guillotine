//
//  GameCell.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/6/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    var game: Optional<Game>
    
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
        self.backgroundColor = UIColor.red
    }
    
    func setGame(game: Game) {
        self.game = Optional.some(game)
    }
}
