//
//  ViewController.swift
//  BattleOOP
//
//  Created by Ron Lipkin on 3/13/16.
//  Copyright © 2016 rolp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameInstance: Game!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameInstance = Game(vc: self)
        gameInstance.displayP1SetupElements()
    }
    
    //Player 1 details outlets
    @IBOutlet weak var p1NameField: UITextField!
    @IBOutlet weak var p1CharSelect: UISegmentedControl!
    @IBOutlet weak var p1DetailsStack: UIStackView!
    
    //Player 2 details outlets
    @IBOutlet weak var p2NameField: UITextField!
    @IBOutlet weak var p2CharSelect: UISegmentedControl!
    @IBOutlet weak var p2DetailsStack: UIStackView!
    
    //Game outlets
    @IBOutlet weak var p1Image: UIImageView!
    @IBOutlet weak var p2Image: UIImageView!
    @IBOutlet weak var p1AttackBtn: UIButton!
    @IBOutlet weak var p2AttackBtn: UIButton!
    @IBOutlet weak var eventsLbl: UILabel!
    @IBOutlet weak var p1HP: UILabel!
    @IBOutlet weak var p1NameLbl: UILabel!
    @IBOutlet weak var p2HP: UILabel!
    @IBOutlet weak var p2NameLbl: UILabel!
    @IBOutlet weak var newGameBtn: UIButton!
    
    //Functions
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func onP1ReadyTapped(sender: AnyObject) {
        gameInstance.createPlayer(1, name: p1NameField.text!, charSelect: p1CharSelect.selectedSegmentIndex)
        gameInstance.hideP1SetupElements()
        gameInstance.displayP2SetupElements()
        view.endEditing(true)
    }
    
    @IBAction func onP2ReadyTapped(sender: AnyObject) {
        gameInstance.createPlayer(2, name: p2NameField.text!, charSelect: p2CharSelect.selectedSegmentIndex)
        gameInstance.hideP2SetupElements()
        gameInstance.startGame()
        view.endEditing(true)
    }
    
    @IBAction func onP1AttackTapped(sender: AnyObject) {
        p1AttackBtn.enabled = false
        p2AttackBtn.enabled = true
        gameInstance.performAttack(gameInstance.player1, enemy: gameInstance.player2)
    }
    
    @IBAction func onP2AttackTapped(sender: AnyObject) {
        gameInstance.performAttack(gameInstance.player2, enemy: gameInstance.player1)
        p1AttackBtn.enabled = true
        p2AttackBtn.enabled = false
    }
    
    @IBAction func onNewGameTapped(sender: AnyObject) {
        gameInstance.restartGame()
    }
    
   

}

