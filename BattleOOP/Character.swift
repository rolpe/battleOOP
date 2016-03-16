//
//  Character.swift
//  BattleOOP
//
//  Created by Ron Lipkin on 3/13/16.
//  Copyright © 2016 rolp. All rights reserved.
//

import Foundation
import UIKit

class Character {
    private var _hp: Int = 100
    private var _attackPwr: Int = 10
    private var _name: String = "Char"
    private var _playerNum: Int = 0
    
    var hp:Int {
        get {
            return _hp
        }
        set (newHp) {
            _hp = newHp
        }
    }
    
    var attackPwr: Int {
        get {
            return _attackPwr
        }
        set (newAttack) {
            _attackPwr = newAttack
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var playerNum: Int {
        get {
            return _playerNum
        }
    }
    
    
    var isAlive: Bool {
        get {
            if self.hp <= 0 {
                return false
            }
            return true
        }
    }
    
    func attemptAttack(attacker: Character, enemy: Character) {
        if enemy.hp > 0 {
            enemy.hp -= attacker.attackPwr
        }
    }
    
    func randomiseAttackPwr(){}
    
    func resetAttackPwr(){}
    
    func setImage(playerNumber: Int) -> UIImage{return UIImage(named: "soldier")!}
}