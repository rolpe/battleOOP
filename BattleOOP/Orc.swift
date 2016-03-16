//
//  Orc.swift
//  BattleOOP
//
//  Created by Ron Lipkin on 3/13/16.
//  Copyright © 2016 rolp. All rights reserved.
//

import Foundation
import UIKit

class Orc: Character {
    
    private var _name: String = "Orc"
    private var _playerNum: Int
    
    init(name: String, playerNum: Int) {
        _name = name
        _playerNum = playerNum
    }
    
    override var name: String {
        get {
            return _name
        }
    }
    
    override var playerNum: Int {
        get {
            return _playerNum
        }
    }
    
    
    override func randomiseAttackPwr(){
        self.attackPwr = Int(arc4random_uniform(UInt32(21)))
    }
    
    override func resetAttackPwr(){
        self.attackPwr = 10
    }
    
    override func setImage(playerNumber: Int) -> UIImage {
        if playerNumber == 2 {
            let flippedImage = UIImage(CGImage: UIImage(named: "orc")!.CGImage!, scale: 1.0, orientation: .UpMirrored)
            return flippedImage
        } else {
            return UIImage(named: "orc")!
        }
    }
}
    