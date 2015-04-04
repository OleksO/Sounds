//
//  Task2.swift
//  sounds
//
//  Created by Oleksandr Ovadenko on 03.04.15.
//  Copyright (c) 2015 Oleksandr Ovadenko. All rights reserved.
//

import UIKit
import AVFoundation

class Task2: UIViewController {
    
    @IBOutlet var lettersLables: Array<UIButton>!
    @IBOutlet var answersLables: Array<UILabel>!  
    
    var correctAnswer = ""
    var correctLabel: UILabel!
    var activeMiniGame: UIButton!
    
    var winSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("win", ofType: "mp3")!)
    var winPlayer = AVAudioPlayer()
    
    var lostSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("fail", ofType: "mp3")!)
    var lostPlayer = AVAudioPlayer()
    
    var keys : [String:String] = ["ВОВК":"О","ПРИЗ":"И","КУЩ":"У","ДРІТ":"І","РАК":"А","ЧЕК":"Е"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
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
    }
    
    func showVariants() {
        for eachletter in lettersLables {
            eachletter.hidden = false
        }
        
    }
    
    func hideVariants() {
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
        activeMiniGame = button
        let name = button.titleLabel!.text!
        correctAnswer = keys["\(name)"]!
        for letters in lettersLables {
            letters.tintColor = UIColor.blueColor()
        }
        switch name {
        case "ВОВК" : correctLabel = answersLables[0]
        case "ПРИЗ" : correctLabel = answersLables[1]
        case "КУЩ" : correctLabel = answersLables[2]
        case "ДРІТ" : correctLabel = answersLables[3]
        case "РАК" : correctLabel = answersLables[4]
        case "ЧЕК" : correctLabel = answersLables[5]
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
    
    @IBAction func vovkButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    @IBAction func pryzButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    
    @IBAction func kushButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    @IBAction func dritButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    @IBAction func rakButton(sender: UIButton) {
        miniGameStart(sender)
    }
    
    @IBAction func chekButton(sender: UIButton) {
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

