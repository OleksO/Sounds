//
//  MixedSizes.swift
//  sounds
//
//  Created by Oleksandr Ovadenko on 05.04.15.
//  Copyright (c) 2015 Oleksandr Ovadenko. All rights reserved.
//



import UIKit
import AVFoundation
import Foundation
import ImageIO

class MixedSizes: UIViewController {

    
    @IBOutlet weak var dancingGirl: UIImageView!
    var theDance = [UIImage(named: "frame_100.png")!, UIImage(named: "frame_101.png")!, UIImage(named: "frame_002.png")!, UIImage(named: "frame_003.png")!, UIImage(named: "frame_004.png")!, UIImage(named: "frame_005.png")!, UIImage(named: "frame_006.png")!, UIImage(named: "frame_107.png")!, UIImage(named: "frame_108.png")!]
    var shallWeDance = false
    
    
    var tryAgainSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tryagain", ofType: "wav")!)
    var goodSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("good", ofType: "wav")!)
    var notYetSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("notYet", ofType: "wav")!)
    
    var tryAgainPlayer = AVAudioPlayer()
    var goodSoundAgainPlayer = AVAudioPlayer()
    var notYetSoundPlayer = AVAudioPlayer()
    
    
    var пеньCorrect = ["П","Е","Н","Ь","О","К"]
    var пеньSolved = 6
    
    @IBOutlet var пеньIncorrectImages: Array<UIImageView>!
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
                dancingGirl.animationImages = theDance
                dancingGirl.animationRepeatCount = 1
                dancingGirl.animationDuration = 1
                dancingGirl.startAnimating()
                shallWeDance = true
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
        goodSoundAgainPlayer = AVAudioPlayer(contentsOfURL: goodSound, error: nil)
        goodSoundAgainPlayer.prepareToPlay()
        goodSoundAgainPlayer.play()
    }
    
    func playTryAgain() {
        tryAgainPlayer = AVAudioPlayer(contentsOfURL: tryAgainSound, error: nil)
        tryAgainPlayer.prepareToPlay()
        tryAgainPlayer.play()
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
    @IBAction func кПеньButton(sender: UIButton) {
        пеньCheck(sender)
    }
    @IBAction func оПеньButton(sender: UIButton) {
        пеньCheck(sender)
    }
    
    @IBAction func theDance(sender: UIButton) {
        if shallWeDance == true {
            dancingGirl.startAnimating()
        } else {
            notYetSoundPlayer = AVAudioPlayer(contentsOfURL: notYetSound, error: nil)
            notYetSoundPlayer.prepareToPlay()
            notYetSoundPlayer.play()
        }
    }
}