//
//  Game.swift
//  Sounds
//
//  Created by Oleksandr Ovadenko on 02.04.15.
//  Copyright (c) 2015 Oleksandr Ovadenko. All rights reserved.
//

import UIKit
import AVFoundation


class Task1: UIViewController {
    
    
    @IBOutlet var lettersLables: Array<UIButton>!
    @IBOutlet var answersLables: Array<UILabel>!
    @IBOutlet weak var flowerOfChoise: UIImageView!
    
    var correctAnswer = ""
    var correctLabel: UILabel!
    var activeMiniGame: UIButton!
    
    
    var winSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("win", ofType: "mp3")!)
    var winPlayer = AVAudioPlayer()
    
    var lostSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("fail", ofType: "mp3")!)
    var lostPlayer = AVAudioPlayer()
    

    
    var keys : [String:String] = ["БУК":"У","ЛАК":"А","СОМ":"О","БИК":"И","ПЕНЬ":"Е","НІС":"І"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        winPlayer = AVAudioPlayer(contentsOfURL: winSound, error: nil)
        winPlayer.prepareToPlay()
        
        lostPlayer = AVAudioPlayer(contentsOfURL: lostSound, error: nil)
        lostPlayer.prepareToPlay()
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showVariants() {
        flowerOfChoise.hidden = false
        for eachletter in lettersLables {
            switch eachletter.titleLabel!.text! {
            case "Е" : eachletter.frame = CGRect(x: flowerOfChoise.frame.origin.x+15, y: flowerOfChoise.frame.origin.y+10, width: 40, height: 40)
            case "О" : eachletter.frame = CGRect(x: flowerOfChoise.frame.origin.x+75, y: flowerOfChoise.frame.origin.y+10, width: 40, height: 40)
            case "А" : eachletter.frame = CGRect(x: flowerOfChoise.frame.origin.x+95, y: flowerOfChoise.frame.origin.y+55, width: 40, height: 40)
            case "И" : eachletter.frame = CGRect(x: flowerOfChoise.frame.origin.x+55, y: flowerOfChoise.frame.origin.y+95, width: 40, height: 40)
            case "І" : eachletter.frame = CGRect(x: flowerOfChoise.frame.origin.x+10, y: flowerOfChoise.frame.origin.y+65, width: 40, height: 40)
            case "У" : eachletter.frame = CGRect(x: flowerOfChoise.frame.origin.x+47, y: flowerOfChoise.frame.origin.y+47, width: 40, height: 40)
            default : return
            }
            
            eachletter.hidden = false
        }
        
    }
    
    func hideVariants() {
        flowerOfChoise.hidden = true
        for eachletter in lettersLables {
            eachletter.hidden = true
        }
        
    }
    
    func checkAnswer(compareWith: String, toCheck: String) -> Bool {
        if compareWith == toCheck {
            return true
        } else {
            return false
        }
        
    }
    
    
    func miniGameStart(button: UIButton) {
        flowerOfChoise.frame = CGRect(x: button.frame.origin.x+341/2-70, y: button.frame.origin.y+70, width: 140, height: 140)
        activeMiniGame = button
        let name = button.titleLabel!.text!
        correctAnswer = keys["\(name)"]!
        for letters in lettersLables {
            letters.tintColor = UIColor.blueColor()
        }
        switch name {
        case "БУК" : correctLabel = answersLables[0]
        case "ЛАК" : correctLabel = answersLables[1]
        case "СОМ" : correctLabel = answersLables[2]
        case "БИК" : correctLabel = answersLables[3]
        case "ПЕНЬ" : correctLabel = answersLables[4]
        case "НІС" : correctLabel = answersLables[5]
        default: return
        }
        showVariants()
    }
    
    
    func letterChosed (sender: UIButton) {
        var text = sender.titleLabel!.text!
        if checkAnswer(correctAnswer, toCheck: text) {
            winPlayer.volume = 0.05
            winPlayer.play()
            hideVariants()
            correctLabel.hidden = false
            activeMiniGame.enabled = false
        } else {
            lostPlayer.volume = 0.05
            lostPlayer.play()
            switch text {
            case "Е" : lettersLables[0].tintColor = UIColor.redColor()
            case "О" : lettersLables[1].tintColor = UIColor.redColor()
            case "А" : lettersLables[2].tintColor = UIColor.redColor()
            case "И" : lettersLables[3].tintColor = UIColor.redColor()
            case "І" : lettersLables[4].tintColor = UIColor.redColor()
            case "У" : lettersLables[5].tintColor = UIColor.redColor()
            default : return
            }
        }
        
    }

    
    @IBAction func bukButton(sender: UIButton) {
        miniGameStart(sender)
    }
 
    @IBAction func lakButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    
    @IBAction func somButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    @IBAction func bykButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    @IBAction func penButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    @IBAction func nisButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    @IBAction func eButton(sender: UIButton) {
        letterChosed(sender)
        
    }
    
    @IBAction func jButton(sender: UIButton) {
        letterChosed(sender)
    }
    
    @IBAction func fButton(sender: UIButton) {
        letterChosed(sender)
    }
    
    @IBAction func sButton(sender: UIButton) {
        letterChosed(sender)
    }
    
    @IBAction func tButton(sender: UIButton) {
        letterChosed(sender)
    }
    
    @IBAction func bButton(sender: UIButton) {
        letterChosed(sender)
    }
    
    
    
}

