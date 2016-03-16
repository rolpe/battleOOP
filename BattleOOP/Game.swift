//
//  Game.swift
//  BattleOOP
//
//  Created by Ron Lipkin on 3/13/16.
//  Copyright © 2016 rolp. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Game: NSObject {
    var vc: ViewController!
    var player1: Character!
    var player2: Character!
    
    //sound variables
    var music: AVAudioPlayer?
    var orcAttackSound: AVAudioPlayer?
    var soldierAttackSound: AVAudioPlayer?
    var orcRoarSound: AVAudioPlayer?
    var soldierYellSound: AVAudioPlayer?
    var player1AttackSound: AVAudioPlayer?
    var player2AttackSound:AVAudioPlayer?
    var cheerSound: AVAudioPlayer?
    
    init(vc: ViewController) {
        super.init()
        self.vc = vc
        declareAudio()
        music?.volume = 0.4
        music?.play()
    }
    
    func setupAudioPlayerWithFile(file: String, type: String) -> AVAudioPlayer? {
        let path = NSBundle.mainBundle().pathForResource(file, ofType: type)
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer: AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        return audioPlayer
    }
    
    func declareAudio() {
        if let orcAttackSoundIn = setupAudioPlayerWithFile("orcAttack", type:"wav") {
            orcAttackSound = orcAttackSoundIn
        }
        
        if let soldierAttackSoundIn = setupAudioPlayerWithFile("soldierAttack", type: "wav") {
            soldierAttackSound = soldierAttackSoundIn
        }
        
        if let soldierYellSoundIn = setupAudioPlayerWithFile("soldierYell", type: "wav") {
            soldierYellSound = soldierYellSoundIn
        }
        
        if let orcRoarSoundIn = setupAudioPlayerWithFile("orcRoar", type: "wav") {
            orcRoarSound = orcRoarSoundIn
        }
        
        if let musicIn = setupAudioPlayerWithFile("windsOfMight", type: "mp3") {
            music = musicIn
            music?.numberOfLoops = -1
        }
        
        if let cheerSoundIn = setupAudioPlayerWithFile("cheer", type: "wav") {
            cheerSound = cheerSoundIn
        }
    }
    
    func createPlayer(playerNumber: Int, name: String, charSelect: Int) {
        if playerNumber == 1 {
            if charSelect == 0 {
                player1 = Soldier(name: name, playerNum: 1)
                vc.p1NameLbl.text = player1.name
                vc.p1Image.image=player1.setImage(playerNumber)
                soldierYellSound?.volume = 1.3
                soldierYellSound?.play()
                player1AttackSound = soldierAttackSound
            } else {
                player1 = Orc(name: name, playerNum: 1)
                vc.p1NameLbl.text = player1.name
                vc.p1Image.image=player1.setImage(playerNumber)
                orcRoarSound?.play()
                player1AttackSound = orcAttackSound
            }
        } else {
            if charSelect == 0 {
                player2 = Soldier(name: name, playerNum: 2)
                vc.p2NameLbl.text = player2.name
                vc.p2Image.image=player2.setImage(playerNumber)
                soldierYellSound?.play()
                player2AttackSound = soldierAttackSound
            } else {
                player2 = Orc(name: name, playerNum: 2)
                vc.p2NameLbl.text = player2.name
                vc.p2Image.image=player2.setImage(playerNumber)
                orcRoarSound?.play()
                player2AttackSound = orcAttackSound 
            }
        }
    }
    
    func performAttack(player: Character, enemy: Character) {
        player.randomiseAttackPwr()
        player.attemptAttack(player, enemy: enemy)
        if(player.playerNum == 1) {
            let origX = vc.p1Image.center.x
            let origY = vc.p1Image.center.y
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseIn, animations: { self.vc.p1Image.center = CGPoint(x: origX + 100, y: origY) }, completion: { finished in (self.player1AttackSound?.play())
                self.updateHPLabels()}
            )
            
            UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseIn, animations: { self.vc.p1Image.center = CGPoint(x: origX, y: origY) }, completion: { finished in }
            )
        } else {
            let origX = vc.p2Image.center.x
            let origY = vc.p2Image.center.y
            
            UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseIn, animations: { self.vc.p2Image.center = CGPoint(x: origX - 100, y: origY) }, completion: {
                finished in (self.player2AttackSound?.play())
                self.updateHPLabels()}
            )
            
            UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseIn, animations: { self.vc.p2Image.center = CGPoint(x: origX, y: origY) }, completion: { finished in }
            )
        }
        
        
        vc.eventsLbl.text = "\(player.name) attacks \(enemy.name) for \(player.attackPwr) HP!"
        
        
        if !enemy.isAlive {
            gameEnded(player)
        }
    }
    
    func startGame() {
        updateHPLabels()
        displayGameElements()
        vc.eventsLbl.text = "Attack!"
    }
    
    func restartGame() {
        hideGameElements()
        displayP1SetupElements()
        vc.p1NameField.text = ""
        vc.p2NameField.text = ""
    }
    
    func gameEnded(winner: Character) {
        vc.eventsLbl.text = "\(winner.name) is victorious!"
        cheerSound?.volume = 0.7
        cheerSound?.play()
        hideGameElements()
        if(winner.playerNum == 1) {
            vc.p1Image.hidden = false
        } else {
            vc.p2Image.hidden = false
        }
        vc.p1HP.hidden = false
        vc.p2HP.hidden = false
        vc.newGameBtn.hidden = false
    }
    
    func displayP1SetupElements() {
        vc.p1DetailsStack.hidden = false
        vc.eventsLbl.text = "Enter Player 1 Details"
    }
    
    func hideP1SetupElements() {
        vc.p1DetailsStack.hidden = true
    }
    
    func displayP2SetupElements() {
        vc.p2DetailsStack.hidden = false
        vc.eventsLbl.text = "Enter Player 2 Details"
    }
    
    func hideP2SetupElements() {
        vc.p2DetailsStack.hidden = true
    }
    
    func displayGameElements() {
        vc.p1Image.hidden = false
        vc.p2Image.hidden = false
        vc.p1AttackBtn.hidden = false
        vc.p2AttackBtn.hidden = false
        vc.p1HP.hidden = false
        vc.p2HP.hidden = false
        vc.p1NameLbl.hidden = false
        vc.p2NameLbl.hidden = false
    }
    
    func hideGameElements() {
        vc.p1Image.hidden = true
        vc.p2Image.hidden = true
        vc.p1AttackBtn.hidden = true
        vc.p2AttackBtn.hidden = true
        vc.p1HP.hidden = true
        vc.p2HP.hidden = true
        vc.p1NameLbl.hidden = true
        vc.p2NameLbl.hidden = true
        vc.newGameBtn.hidden = true
    }
    
    func updateHPLabels() {
        if player1.hp < 0 {
            vc.p1HP.text = "0 HP"
        } else {
            vc.p1HP.text = "\(player1.hp) HP"
        }
        
        if player2.hp < 0 {
            vc.p2HP.text = "0 HP"
        } else {
            vc.p2HP.text = "\(player2.hp) HP"
        }
    }
    
}
