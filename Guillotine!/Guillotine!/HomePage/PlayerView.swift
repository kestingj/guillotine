//
//  PlayerView.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 10/7/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    private static let HAND_COUNT_TAG = 0xDEADBEEF
    private static let IMAGE_VIEW_TAG = 0xFFFFFFFF
    
    
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        addSubview(<#T##view: UIView##UIView#>)
//    }
    
    func setPlayer(playerId: String, handCount: Int) {
        let playerImageView = getPlayerImageView(playerId: playerId)
        playerImageView.layer.masksToBounds=true
        playerImageView.layer.borderWidth=1.5
        playerImageView.layer.borderColor = UIColor.white.cgColor
        playerImageView.tag = PlayerView.IMAGE_VIEW_TAG
        addSubview(playerImageView)
        let playerIdView = UITextView()
        playerIdView.text = playerId
        addSubview(playerIdView)
        let handCountView = UITextView()
        handCountView.text = handCount.description
        handCountView.tag = PlayerView.HAND_COUNT_TAG
        addSubview(handCountView)
        setConstraints(playerImageView: playerImageView, playerIdView: playerIdView, handCountView: handCountView)
    }
    
    func setConstraints(playerImageView: UIImageView, playerIdView: UITextView, handCountView: UITextView) {
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        playerIdView.translatesAutoresizingMaskIntoConstraints = false
        handCountView.translatesAutoresizingMaskIntoConstraints = false
        
        // playerImageView
        playerImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playerImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        playerImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        playerImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        // playerIdView
        playerIdView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playerIdView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        playerIdView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        playerIdView.topAnchor.constraint(equalTo: playerImageView.bottomAnchor).isActive = true
        playerIdView.font = UIFont.systemFont(ofSize: 10)
        
        // handCountView
        handCountView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        handCountView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        handCountView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        handCountView.topAnchor.constraint(equalTo: playerIdView.bottomAnchor).isActive = true
        handCountView.font = UIFont.systemFont(ofSize: 10)
    }
    
    func setCount(handCount: Int) {
        if let countView = self.viewWithTag(PlayerView.HAND_COUNT_TAG) as? UITextView {
            countView.text = handCount.description
        }
    }
    
    func boldPlayer() {
        if let playerImageView = self.viewWithTag(PlayerView.IMAGE_VIEW_TAG) as? UIImageView {
            playerImageView.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func unboldPlayer() {
        if let playerImageView = self.viewWithTag(PlayerView.IMAGE_VIEW_TAG) as? UIImageView {
            playerImageView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func getPlayerImageView(playerId: String) -> UIImageView {
        let image = UIImage(named: "defaultPic")
        return UIImageView(image: image)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}
