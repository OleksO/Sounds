//
//  Game.swift
//  Sounds
//
//  Created by Oleksandr Ovadenko on 02.04.15.
//  Copyright (c) 2015 Oleksandr Ovadenko. All rights reserved.
//

import UIKit
import AVFoundation

extension Array {
    func shuffled() -> [T] {
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
}

class FindVowels: UIViewController {

    @IBOutlet var lettersButtons: Array<UIButton>! // массив гласных в конкретном порядке Е, А, О, И, Е, І
    @IBOutlet var pageButtons:Array<UIButton>! // кнопки с картинками

    
    @IBOutlet var testLabels: [UILabel]!
    @IBOutlet var answerLabels: [UILabel]!
    
    var answersForMiniGames:Array<String> = []
    var activeMiniGame: UIButton!
    var pressCounter: Int = 0
    var activePage:Int = 1
    
    var winSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("good", ofType: "wav")!)
    var trySound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tryagain", ofType: "wav")!)
    
    var player = AVAudioPlayer()
    var еPlayer = AVAudioPlayer()
    var оPlayer = AVAudioPlayer()
    var аPlayer = AVAudioPlayer()
    var иPlayer = AVAudioPlayer()
    var іPlayer = AVAudioPlayer()
    var уPlayer = AVAudioPlayer()
    
    var leftToSolve = 6
    
    
    /* 
        Правим только переменые снизу
        let page....Words
        Объявляем слова для каждой странице. не определяет порядок отображения на странице.
        var букSound
        Прописываем звуки для каждого изображения (предварительно перенести файлы в проект)

    */
    let pageOneWords = ["БУК","ЛАК","СОМ","БИК","ПЕНЬ","НІС"]
    let pageTwoWords = ["БИК","ПЕНЬ","НІС","СОМ","ЛАК","БУК"]


    var букSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("бук", ofType: "wav")!)
    var лакSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("лак", ofType: "wav")!)
    var сомSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("сом", ofType: "wav")!)
    var бикSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("бик", ofType: "wav")!)
    var нісSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ніс", ofType: "wav")!)
    var пеньSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("пень", ofType: "wav")!)
    
    /*
        Ниже ничего не править
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage(activePage)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func miniGameStart(button: UIButton) {
        pressCounter = 1
        activeMiniGame = button
        activeMiniGame.titleLabel!.text! = button.titleLabel!.text!
        var name = button.titleLabel!.text!
        
        lettersButtons[0].frame = CGRect(x: activeMiniGame.frame.origin.x+15, y: activeMiniGame.frame.origin.y+20, width: 60, height: 60)
        lettersButtons[1].frame = CGRect(x: activeMiniGame.frame.origin.x+15, y: activeMiniGame.frame.origin.y+100, width: 60, height: 60)
        lettersButtons[2].frame = CGRect(x: activeMiniGame.frame.origin.x+15, y: activeMiniGame.frame.origin.y+180, width: 60, height: 60)
        lettersButtons[3].frame = CGRect(x: activeMiniGame.frame.origin.x+309, y: activeMiniGame.frame.origin.y+20, width: 60, height: 60)
        lettersButtons[4].frame = CGRect(x: activeMiniGame.frame.origin.x+309, y: activeMiniGame.frame.origin.y+100, width: 60, height: 60)
        lettersButtons[5].frame = CGRect(x: activeMiniGame.frame.origin.x+309, y: activeMiniGame.frame.origin.y+180, width: 60, height: 60)
        
        for i in 0...5 {
           lettersButtons[i].hidden = false
        }
        testLabels[button.titleLabel!.text!.toInt()!].hidden = false
    }

    
    func letterChosed (sender: UIButton) {
            if sender.titleLabel!.text! == answersForMiniGames[activeMiniGame.titleLabel!.text!.toInt()!] {
                pressCounter = 0
                activeMiniGame.enabled = false
                activeMiniGame.highlighted = true
                leftToSolve = leftToSolve - 1
                for i in 0...5 {
                    lettersButtons[i].hidden = true
                }
                testLabels[activeMiniGame.titleLabel!.text!.toInt()!].hidden = true
                answerLabels[activeMiniGame.titleLabel!.text!.toInt()!].hidden = false
                
            } else {
                еPlayer = AVAudioPlayer(contentsOfURL: trySound, error: nil)
                еPlayer.prepareToPlay()
                оPlayer = AVAudioPlayer(contentsOfURL: trySound, error: nil)
                оPlayer.prepareToPlay()
                аPlayer = AVAudioPlayer(contentsOfURL: trySound, error: nil)
                аPlayer.prepareToPlay()
                иPlayer = AVAudioPlayer(contentsOfURL: trySound, error: nil)
                иPlayer.prepareToPlay()
                іPlayer = AVAudioPlayer(contentsOfURL: trySound, error: nil)
                іPlayer.prepareToPlay()
                уPlayer = AVAudioPlayer(contentsOfURL: trySound, error: nil)
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
    
        
        func gameOver() -> Bool {
            if leftToSolve == 0 {
                return true
            } else {
                return false
            }
        }
        

        
        func loadPage(nextPage: Int) {
            
            switch nextPage {
            case 1: definingEverythingForPage(pageOneWords)
            case 2: definingEverythingForPage(pageTwoWords)
            default: return
            }
            
        }
    
    func definingEverythingForPage (set: Array<String>) {

        for i in 0..<answerLabels.count {
            answerLabels[i].hidden = true
        }
        
        let pageOneWordsShuffled = pageOneWords.shuffled()
        for button in pageButtons {
            button.enabled = false
        }
        
        for i in 0...5 {
            pageButtons[i].setImage(UIImage(named: "\(pageOneWordsShuffled[i])"+".png"), forState: .Normal)
            pageButtons[i].setTitle("\(i)", forState: .Normal)
        }
        for button in pageButtons {
            button.enabled = true
        }
        
        for var y=0; y<6; y++ {
            var namesAsArrayOfChars = Array(pageOneWordsShuffled[y])
            var namesAsArrayOfCharsReadyToShow: Array<Character> = []
            var key:String = ""
            
            for char in namesAsArrayOfChars {
                if (char == "У") || (char == "Е") || (char == "А") || (char == "О") || (char == "И") || (char == "І") {
                    namesAsArrayOfCharsReadyToShow.append(" ")
                    key = String(char)
                    answersForMiniGames.append(key)
                } else {
                    namesAsArrayOfCharsReadyToShow.append(char)
                }
            }
            
            var nameReadyToShow:String = ""
            
            for var i=0; i<namesAsArrayOfCharsReadyToShow.count; i++ {
                nameReadyToShow += String(namesAsArrayOfCharsReadyToShow[i])
            }
            
            testLabels[y].text = nameReadyToShow
            answerLabels[y].text = pageOneWordsShuffled[y]
            
        }
    }
    
    
        func shallWeMoveToNextPage() {
            if gameOver() {
                
                var seconds = 2.0
                var delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    
                    self.player = AVAudioPlayer(contentsOfURL: self.winSound, error: nil)
                    self.player.prepareToPlay()
                    self.player.play()
                    
                })
                
                seconds = 5.0
                delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    
                    self.activePage += 1
                    self.loadPage(self.activePage)
                    
                })
            }
        }

    func whenPressingTheImage (sender: UIButton) {
        switch pressCounter {
        case 0 : miniGameStart(sender)
        case 2 : if activeMiniGame == sender {
            //проиграть название предмета
            }
        default : return
        }
    }

    @IBAction func firstButton(sender: UIButton) {
        whenPressingTheImage(sender)
            }

    
    @IBAction func secondButton(sender: UIButton) {
        whenPressingTheImage(sender)
    }
    
    @IBAction func thirdButton(sender: UIButton) {
        whenPressingTheImage(sender)
    }
    
    @IBAction func fourthButton(sender: UIButton) {
        whenPressingTheImage(sender)
    }
    
    @IBAction func fifthButton(sender: UIButton) {
        whenPressingTheImage(sender)
    }
    
    @IBAction func sixthButton(sender: UIButton) {
        whenPressingTheImage(sender)
    }
    

    
    
    @IBAction func еButton(sender: UIButton) {
        letterChosed(sender)
        shallWeMoveToNextPage()
    }
    
    @IBAction func оButton(sender: UIButton) {
        letterChosed(sender)
        shallWeMoveToNextPage()
    }
    
    @IBAction func аButton(sender: UIButton) {
        letterChosed(sender)
        shallWeMoveToNextPage()
    }
    
    @IBAction func иButton(sender: UIButton) {
        letterChosed(sender)
        shallWeMoveToNextPage()
    }
    
    @IBAction func іButton(sender: UIButton) {
        letterChosed(sender)
        shallWeMoveToNextPage()
    }
    
    @IBAction func уButton(sender: UIButton) {
        letterChosed(sender)
        shallWeMoveToNextPage()
    }
}