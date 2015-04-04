//
//  Game.swift
//  Sounds
//
//  Created by Oleksandr Ovadenko on 02.04.15.
//  Copyright (c) 2015 Oleksandr Ovadenko. All rights reserved.
//

import UIKit
import AVFoundation

class FindVowels: UIViewController {
    
    @IBOutlet var lettersButtons: Array<UIButton>!
    @IBOutlet var lettersImages: Array<UIImageView>!
    
    @IBOutlet var бук:Array<UIImageView>!
    @IBOutlet var лак:Array<UIImageView>!
    @IBOutlet var сом:Array<UIImageView>!
    @IBOutlet var бик:Array<UIImageView>!
    @IBOutlet var пень:Array<UIImageView>!
    @IBOutlet var ніс:Array<UIImageView>!

    
    var activeMiniGame: UIButton!
    var correctAnswerImage:UIImageView!
    var correctAnswerButton:UIButton!
    var pressCounter: Int = 0
    
    var букSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("бук", ofType: "wav")!)
    var лакSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("лак", ofType: "wav")!)
    var сомSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("сом", ofType: "wav")!)
    var бикSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("бик", ofType: "wav")!)
    var пеньSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("пень", ofType: "wav")!)
    var нісSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ніс", ofType: "wav")!)
    
    var winSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("good", ofType: "wav")!)
    var tryAgainSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tryagain", ofType: "wav")!)
    
    var player = AVAudioPlayer()
    var еPlayer = AVAudioPlayer()
    var оPlayer = AVAudioPlayer()
    var аPlayer = AVAudioPlayer()
    var иPlayer = AVAudioPlayer()
    var іPlayer = AVAudioPlayer()
    var уPlayer = AVAudioPlayer()
    
    var leftToSolve = 6
    

    
    
    func miniGameStart(button: UIButton) {
        pressCounter = 1
        activeMiniGame = button
        let name = button.titleLabel!.text!
        
        lettersButtons[0].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+20, width: 60, height: 60)
        lettersButtons[1].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+100, width: 60, height: 60)
        lettersButtons[2].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+180, width: 60, height: 60)
        lettersButtons[3].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+20, width: 60, height: 60)
        lettersButtons[4].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+100, width: 60, height: 60)
        lettersButtons[5].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+180, width: 60, height: 60)
        
        lettersImages[0].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+20, width: 60, height: 60)
        lettersImages[1].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+100, width: 60, height: 60)
        lettersImages[2].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+180, width: 60, height: 60)
        lettersImages[3].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+20, width: 60, height: 60)
        lettersImages[4].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+100, width: 60, height: 60)
        lettersImages[5].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+180, width: 60, height: 60)
        
        for letters in lettersButtons {
            letters.hidden = false
        }
        for letters in lettersImages {
            letters.hidden = false
        }
        
        switch name {
        case "БУК" :
            player = AVAudioPlayer(contentsOfURL: букSound, error: nil)
            player.prepareToPlay()
            бук[0].frame = CGRect(x: button.frame.origin.x+139, y: button.frame.origin.y+302, width: 30, height: 30)
            бук[1].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            бук[2].frame = CGRect(x: button.frame.origin.x+215, y: button.frame.origin.y+302, width: 30, height: 30)
            бук[3].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
            correctAnswerButton = lettersButtons[5]
            
            for var i=0; i<бук.count-1; i++ {
                бук[i].hidden = false
            }
            
            correctAnswerImage = бук[3]
            correctAnswerImage.frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
       
        case "ЛАК" :
            player = AVAudioPlayer(contentsOfURL: лакSound, error: nil)
            player.prepareToPlay()
            лак[0].frame = CGRect(x: button.frame.origin.x+139, y: button.frame.origin.y+302, width: 30, height: 30)
            лак[1].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            лак[2].frame = CGRect(x: button.frame.origin.x+215, y: button.frame.origin.y+302, width: 30, height: 30)
            лак[3].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
            correctAnswerButton = lettersButtons[2]
            
            for var i=0; i<лак.count-1; i++ {
                лак[i].hidden = false
            }
            
            correctAnswerImage = лак[3]
            correctAnswerImage.frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
        case "СОМ" :
            player = AVAudioPlayer(contentsOfURL: сомSound, error: nil)
            player.prepareToPlay()
            сом[0].frame = CGRect(x: button.frame.origin.x+139, y: button.frame.origin.y+302, width: 30, height: 30)
            сом[1].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            сом[2].frame = CGRect(x: button.frame.origin.x+215, y: button.frame.origin.y+302, width: 30, height: 30)
            сом[3].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
            correctAnswerButton = lettersButtons[1]
            
            for var i=0; i<сом.count-1; i++ {
                сом[i].hidden = false
            }
            
            correctAnswerImage = сом[3]
            correctAnswerImage.frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
        case "БИК" :
            player = AVAudioPlayer(contentsOfURL: бикSound, error: nil)
            player.prepareToPlay()
            бик[0].frame = CGRect(x: button.frame.origin.x+139, y: button.frame.origin.y+302, width: 30, height: 30)
            бик[1].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            бик[2].frame = CGRect(x: button.frame.origin.x+215, y: button.frame.origin.y+302, width: 30, height: 30)
            бик[3].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
            correctAnswerButton = lettersButtons[3]
            
            for var i=0; i<бик.count-1; i++ {
                бик[i].hidden = false
            }
            
            correctAnswerImage = бик[3]
            correctAnswerImage.frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
        case "ПЕНЬ" :
            player = AVAudioPlayer(contentsOfURL: пеньSound, error: nil)
            player.prepareToPlay()
            пень[0].frame = CGRect(x: button.frame.origin.x+120, y: button.frame.origin.y+302, width: 30, height: 30)
            пень[1].frame = CGRect(x: button.frame.origin.x+158, y: button.frame.origin.y+302, width: 30, height: 30)
            пень[2].frame = CGRect(x: button.frame.origin.x+196, y: button.frame.origin.y+302, width: 30, height: 30)
            пень[3].frame = CGRect(x: button.frame.origin.x+234, y: button.frame.origin.y+302, width: 30, height: 30)
            пень[4].frame = CGRect(x: button.frame.origin.x+158, y: button.frame.origin.y+302, width: 30, height: 30)
            
            correctAnswerButton = lettersButtons[0]
            
            for var i=0; i<пень.count-1; i++ {
                пень[i].hidden = false
            }
            
            correctAnswerImage = пень[4]
            correctAnswerImage.frame = CGRect(x: button.frame.origin.x+158, y: button.frame.origin.y+302, width: 30, height: 30)
            
        case "НІС" :
            player = AVAudioPlayer(contentsOfURL: нісSound, error: nil)
            player.prepareToPlay()
            ніс[0].frame = CGRect(x: button.frame.origin.x+139, y: button.frame.origin.y+302, width: 30, height: 30)
            ніс[1].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            ніс[2].frame = CGRect(x: button.frame.origin.x+215, y: button.frame.origin.y+302, width: 30, height: 30)
            ніс[3].frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
            correctAnswerButton = lettersButtons[4]
            
            for var i=0; i<ніс.count-1; i++ {
                ніс[i].hidden = false
            }
            
            correctAnswerImage = ніс[3]
            correctAnswerImage.frame = CGRect(x: button.frame.origin.x+177, y: button.frame.origin.y+302, width: 30, height: 30)
            
        default: return
        }
    }
    
    func letterChosed (sender: UIButton) {
        if sender == correctAnswerButton {
            hideVariants()
            correctAnswerImage.hidden = false
            pressCounter = 0
            activeMiniGame.hidden = true
            player.play()
            leftToSolve = leftToSolve - 1
        } else {
            еPlayer = AVAudioPlayer(contentsOfURL: tryAgainSound, error: nil)
            еPlayer.prepareToPlay()
            оPlayer = AVAudioPlayer(contentsOfURL: tryAgainSound, error: nil)
            оPlayer.prepareToPlay()
            аPlayer = AVAudioPlayer(contentsOfURL: tryAgainSound, error: nil)
            аPlayer.prepareToPlay()
            иPlayer = AVAudioPlayer(contentsOfURL: tryAgainSound, error: nil)
            иPlayer.prepareToPlay()
            іPlayer = AVAudioPlayer(contentsOfURL: tryAgainSound, error: nil)
            іPlayer.prepareToPlay()
            уPlayer = AVAudioPlayer(contentsOfURL: tryAgainSound, error: nil)
            уPlayer.prepareToPlay()
            
            
            switch sender {
            case lettersButtons[0] : pressCounter = 2; еPlayer.play()
            case lettersButtons[1] : pressCounter = 2; оPlayer.play()
            case lettersButtons[2] : pressCounter = 2; аPlayer.play()
            case lettersButtons[3] : pressCounter = 2; иPlayer.play()
            case lettersButtons[4] : pressCounter = 2; іPlayer.play()
            case lettersButtons[5] : pressCounter = 2; уPlayer.play()
            default : pressCounter = 2
          }
        }
    }

    
    func hideVariants() {
        for letters in lettersButtons {
            letters.hidden = true
        }
        for letters in lettersImages {
            letters.hidden = true
        }

        }
    
    func checkIfGameOver() -> Bool {
        if leftToSolve == 0 {
            let seconds = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.player = AVAudioPlayer(contentsOfURL: self.winSound, error: nil)
                self.player.prepareToPlay()
                self.player.play()
                })
            return true
        } else {
            return false
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func букButton(sender: UIButton) {
        
        switch pressCounter {
        case 0 : miniGameStart(sender)
        case 2 : player.play()
        default : return
            
        }
    }

    
    @IBAction func лакButton(sender: UIButton) {
        switch pressCounter {
        case 0 : miniGameStart(sender)
        case 2 : player.play()
        default : return
        }
    }
    
    @IBAction func сомButton(sender: UIButton) {
        switch pressCounter {
        case 0 : miniGameStart(sender)
        case 2 : player.play()
        default : return
        }
    }
    
    @IBAction func бикButton(sender: UIButton) {
        switch pressCounter {
        case 0 : miniGameStart(sender)
        case 2 : player.play()
        default : return
        }
    }
    
    @IBAction func пеньButton(sender: UIButton) {
        switch pressCounter {
        case 0 : miniGameStart(sender)
        case 2 : player.play()
        default : return
        }
    }
    
    @IBAction func нісButton(sender: UIButton) {
        switch pressCounter {
        case 0 : miniGameStart(sender)
        case 2 : player.play()
        default : return
        }
    }
    
    @IBAction func еButton(sender: UIButton) {
        letterChosed(sender)
        if checkIfGameOver() == true {
            let seconds = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("toTask2", sender: nil)
            })
            
        }

    }
    
    @IBAction func оButton(sender: UIButton) {
        letterChosed(sender)
        if checkIfGameOver() == true {
            let seconds = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("toTask2", sender: nil)
            })
            
        }

    }
    
    @IBAction func аButton(sender: UIButton) {
        letterChosed(sender)
        if checkIfGameOver() == true {
            let seconds = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("toTask2", sender: nil)
            })
            
        }
    }
    
    @IBAction func иButton(sender: UIButton) {
        letterChosed(sender)
        if checkIfGameOver() == true {
            let seconds = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("toTask2", sender: nil)
            })
            
        }

    }
    
    @IBAction func іButton(sender: UIButton) {
        letterChosed(sender)
        if checkIfGameOver() == true {
            let seconds = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("toTask2", sender: nil)
            })
            
        }

    }
    
    @IBAction func уButton(sender: UIButton) {
        letterChosed(sender)
        if checkIfGameOver() == true {
            let seconds = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("toTask2", sender: nil)
            })
            
        }

    }

    

}
