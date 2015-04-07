//
//  MixedLetters.swift
//  sounds
//
//  Created by Oleksandr Ovadenko on 05.04.15.
//  Copyright (c) 2015 Oleksandr Ovadenko. All rights reserved.
//


import UIKit
import AVFoundation

class MixedLetters: UIViewController {
    
    var tryAgainSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tryagain", ofType: "wav")!)
    var goodSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("good", ofType: "wav")!)
    var player = AVAudioPlayer()
    
    @IBOutlet var emptySpaces: Array<UIImageView>!
    
    var пеньCorrect = ["П","Е","Н","Ь"]
    var пеньSolved = 4
    @IBOutlet var пеньCorrectImages: Array<UIImageView>!
    @IBOutlet var пеньButtons: Array<UIButton>!
    
    
    
    func пеньCheck(sender: UIButton) {
            if sender.titleLabel!.text! == пеньCorrect[0] {
                пеньCorrectImages[0].hidden = false
                пеньCorrect.removeAtIndex(0)
                пеньCorrectImages.removeAtIndex(0)
                пеньSolved -= 1
                if пеньSolved == 0 {
                    for var i=0; i<пеньButtons.count; i++ {
                        пеньButtons[i].hidden = true
                    }
                    playGood()
                }
            } else {
                playTryAgain()

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
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    func playGood() {
        player = AVAudioPlayer(contentsOfURL: goodSound, error: nil)
        player.prepareToPlay()
        player.play()
    }
    
    func playTryAgain() {
        player = AVAudioPlayer(contentsOfURL: tryAgainSound, error: nil)
        player.prepareToPlay()
        player.play()
    }
    
    
    
    @IBAction func нПеньButton(sender: UIButton) {
        пеньCheck(sender)
        }
    @IBAction func ьПеньButton(sender: UIButton) {
        пеньCheck(sender)
    }
    @IBAction func пПеньButton(sender: UIButton) {
        пеньCheck(sender)
    }
    @IBAction func еПеньButton(sender: UIButton) {
        пеньCheck(sender)
    }
    
    @IBAction func showMaxCapacityOfTheLine(sender: UIButton) {
        if emptySpaces[0].hidden == true {
            for var i=0; i<emptySpaces.count; i++ {
                emptySpaces[i].hidden = false
            }
        } else {
            for var i=0; i<emptySpaces.count; i++ {
                emptySpaces[i].hidden = true
        }
        
    }
    
    }
    
}