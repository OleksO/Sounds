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
    
    
    @IBOutlet weak var startImageOnly: UIImageView!
    
    @IBOutlet weak var mainScreen: UIImageView!
    
    @IBOutlet weak var infoButtonIcon: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet var pageBackgrounds: [UIImageView]!
    
    @IBOutlet var lettersButtons: Array<UIButton>! // массив гласных в конкретном порядке Е, А, О, И, Е, І

    @IBOutlet var pageButtons:Array<UIButton>! // кнопки с картинками

    @IBOutlet var testLabels: [UILabel]!
    
    @IBOutlet var answerLabels: [UILabel]!
    
    @IBOutlet weak var reloadButton: UIButton!
    
    @IBOutlet weak var mainMenuButton: UIButton!
    
    var mask: CALayer?
    
    var gameSoundsStrings:Array<String> = [" "," "," "," "," "," "]
    
    var answersForMiniGames:Array<String> = []
    var activeMiniGame: UIButton!
    var pressCounter: Int = 0
    var activePage:Int = 1
    var madeUpPage = [" "," "," "," "," "," "]
    
    var correctSound1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("correct1", ofType: "mp3")!)
    var correctSound2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("correct2", ofType: "mp3")!)
    var correctSound3 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("correct3", ofType: "mp3")!)
    var correctSound4 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("correct4", ofType: "mp3")!)
    var correctSound5 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("correct5", ofType: "mp3")!)


    
    var wrongSound1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong1", ofType: "mp3")!)
    var wrongSound2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong2", ofType: "mp3")!)
    var wrongSound3 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong3", ofType: "mp3")!)
    var wrongSound4 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong4", ofType: "mp3")!)
    var wrongSound5 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong5", ofType: "mp3")!)


    var spellSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("spell", ofType: "mp3")!)
    
    var mainTheme = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("maintheme", ofType: "mp3")!)
    
    
    var player = AVAudioPlayer()
    var еPlayer = AVAudioPlayer()
    var оPlayer = AVAudioPlayer()
    var аPlayer = AVAudioPlayer()
    var иPlayer = AVAudioPlayer()
    var іPlayer = AVAudioPlayer()
    var уPlayer = AVAudioPlayer()
    
    var leftToSolve = 6
    var numberOfWordsArray:Array<Int> = []
    
    
    /* 
        Правим только переменые снизу
        Объявляем слова на каждую букву.
        Для каждого слова, что встречается, НЕОБХОДИМО наличие изображения и звукового файла
        Изображение (Ш х В): 768 × 682 pixels, прозрачный фон
        "БУК": БУК.mp3 БУК.png

    */
    
    let уWords = ["БУК","КУЩ","ШНУР","СУП","ЛУК","ЩУР","ВУЖ","ДУШ","ЗУБ","ДУБ","КУТ","СУК"]
    let аWords = ["ЛАК","РАК","ХРАМ","САК","БАНТ","МАК","ДАХ","САД","БАК","ЧАЙ","ГАК","ГАЙ"]
    let оWords = ["СОМ","ВОВК","ЛОСЬ","ЛОБ","ДОЩ","СОН","ЛОМ","ЙОД","ТОМ","ТОРТ","БОРЩ","БОКС"]
    let иWords = ["БИК","ПРИЗ","ЛИН","ЛИС","ДИСК","ЖИР","ЛИСТ","СИН","ТИН","ДИМ","ТИГР","КИТ"]
    let еWords = ["ПЕНЬ","ЧЕК","ЛЕВ","ДЕНЬ","МЕД","КРЕМ","ПЕС","ЖЕЗЛ","ДЕНЬ","КРЕМ","ЦЕП","ХРЕСТ"]
    let іWords = ["НІС","ДРІТ","КРІП","НІЧ","ДРІЗД","СІК","ТІНЬ","БІБ","ПІЧ","ДІД","КРІТ","НІЖ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadButton.hidden = true
        mainMenuButton.hidden = true
        
        self.mask = CALayer()
        self.mask!.contents = UIImage(named: "starts")!.CGImage
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 76.8, height: 102.4)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: mainScreen.frame.size.width/2, y: mainScreen.frame.size.height/2)
        mainScreen.layer.mask = mask
        
        animateMask()
        
        var seconds = 2.0
        var delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.player = AVAudioPlayer(contentsOfURL: self.mainTheme, error: nil)
            self.player.prepareToPlay()
            self.player.volume = 0.4
            self.player.play()
            
        })
        
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
        
        
        lettersButtons[0].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+20, width: 60, height: 60)
        lettersButtons[1].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+100, width: 60, height: 60)
        lettersButtons[2].frame = CGRect(x: button.frame.origin.x+15, y: button.frame.origin.y+180, width: 60, height: 60)
        lettersButtons[3].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+20, width: 60, height: 60)
        lettersButtons[4].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+100, width: 60, height: 60)
        lettersButtons[5].frame = CGRect(x: button.frame.origin.x+309, y: button.frame.origin.y+180, width: 60, height: 60)
        
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
                answerLabels[activeMiniGame.titleLabel!.text!.toInt()!].backgroundColor = UIColor.clearColor()
                let i = activeMiniGame.titleLabel!.text!.toInt()!
                
                                let correctSounds = [correctSound1, correctSound2, correctSound3, correctSound4, correctSound5]
                                var correctSoundsShuffled = correctSounds.shuffled()
                                let correctSound = correctSoundsShuffled[0]
                
                                var seconds = 0.0
                                var delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                                var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                
                                    self.player = AVAudioPlayer(contentsOfURL: correctSound, error: nil)
                                    self.player.prepareToPlay()
                                    self.player.volume = 9
                                    self.player.play()
                                    
                                })
                
                
            } else {
                
                let wrongSounds = [wrongSound1, wrongSound2, wrongSound3, wrongSound4, wrongSound5]
                var wrongSoundsShuffled = wrongSounds.shuffled()
                let wrongSound = wrongSoundsShuffled[0]
                
                еPlayer = AVAudioPlayer(contentsOfURL: wrongSound, error: nil)
                еPlayer.prepareToPlay()
                оPlayer = AVAudioPlayer(contentsOfURL: wrongSound, error: nil)
                оPlayer.prepareToPlay()
                аPlayer = AVAudioPlayer(contentsOfURL: wrongSound, error: nil)
                аPlayer.prepareToPlay()
                иPlayer = AVAudioPlayer(contentsOfURL: wrongSound, error: nil)
                иPlayer.prepareToPlay()
                іPlayer = AVAudioPlayer(contentsOfURL: wrongSound, error: nil)
                іPlayer.prepareToPlay()
                уPlayer = AVAudioPlayer(contentsOfURL: wrongSound, error: nil)
                уPlayer.prepareToPlay()
                
                switch sender {
                case lettersButtons[0] : pressCounter = 2; self.еPlayer.volume = 6; еPlayer.play()
                case lettersButtons[1] : pressCounter = 2; self.оPlayer.volume = 6; оPlayer.play()
                case lettersButtons[2] : pressCounter = 2; self.аPlayer.volume = 6; аPlayer.play()
                case lettersButtons[3] : pressCounter = 2; self.иPlayer.volume = 6; иPlayer.play()
                case lettersButtons[4] : pressCounter = 2; self.іPlayer.volume = 6; іPlayer.play()
                case lettersButtons[5] : pressCounter = 2; self.уPlayer.volume = 6; уPlayer.play()
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
            
            reloadButton.hidden = false
            mainMenuButton.hidden = false
            
            let numbersShuffled = numberOfWordsArray.shuffled()
            
            if уWords[numbersShuffled[0]] != madeUpPage[0] {
                madeUpPage[0] = уWords[numbersShuffled[0]]
            } else {
                madeUpPage[0] = уWords[numbersShuffled[2]]
            }
            
            if еWords[numbersShuffled[0]] != madeUpPage[0] {
                madeUpPage[1] = еWords[numbersShuffled[0]]
            } else {
                madeUpPage[1] = еWords[numbersShuffled[2]]
            }
            
            if аWords[numbersShuffled[0]] != madeUpPage[0] {
                madeUpPage[2] = аWords[numbersShuffled[0]]
            } else {
                madeUpPage[2] = аWords[numbersShuffled[3]]
            }
            
            if оWords[numbersShuffled[0]] != madeUpPage[0] {
                madeUpPage[3] = оWords[numbersShuffled[4]]
            } else {
                madeUpPage[3] = оWords[numbersShuffled[1]]
            }
            
            if иWords[numbersShuffled[0]] != madeUpPage[0] {
                madeUpPage[4] = иWords[numbersShuffled[5]]
            } else {
                madeUpPage[5] = иWords[numbersShuffled[1]]
            }
            
            if іWords[numbersShuffled[0]] != madeUpPage[0] {
                madeUpPage[5] = іWords[numbersShuffled[1]]
            } else {
                madeUpPage[5] = іWords[numbersShuffled[1]]
            }

            definingEverythingForPage(madeUpPage)
        }
    
    func definingEverythingForPage (set: Array<String>) {
        
        let numArray = [0,1,2,3,4,5]
        var numArrayShuffled = numArray.shuffled()
        pageBackgrounds[numArrayShuffled[0]].image = UIImage(named: "miniGamePlayground1.png")
        pageBackgrounds[numArrayShuffled[1]].image = UIImage(named: "miniGamePlayground2.png")
        pageBackgrounds[numArrayShuffled[2]].image = UIImage(named: "miniGamePlayground3.png")
        pageBackgrounds[numArrayShuffled[3]].image = UIImage(named: "miniGamePlayground4.png")
        pageBackgrounds[numArrayShuffled[4]].image = UIImage(named: "miniGamePlayground5.png")
        pageBackgrounds[numArrayShuffled[5]].image = UIImage(named: "miniGamePlayground6.png")
        
        answersForMiniGames = []
        leftToSolve = 6
        gameSoundsStrings = [" "," "," "," "," "," "]
        
        for i in 0...5 {
            lettersButtons[i].hidden = true
        }
        
        for i in 0..<answerLabels.count {
            testLabels[i].hidden = true
        }
        
        for i in 0..<answerLabels.count {
            answerLabels[i].hidden = true
        }
        
        let setShuffled = set.shuffled()
        for button in pageButtons {
            button.enabled = false
        }
        
        var apearenceOrder = [0,1,2,3,4,5].shuffled()

        self.player = AVAudioPlayer(contentsOfURL: spellSound, error: nil)
        self.player.prepareToPlay()
        self.player.volume = 0.4
        self.player.play()
        
        for place in apearenceOrder {
            
            var seconds:Double = Double(apearenceOrder[place])*0.12
            var delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {

                self.pageButtons[place].setImage(UIImage(named: "\(setShuffled[place])"+".png"), forState: .Normal)
                
            })
         
            pageButtons[place].setTitle("\(place)", forState: .Normal)
            var quickNSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("\(setShuffled[place])", ofType: "mp3")!)!
            let quickNSURLAsSring = quickNSURL.absoluteString
            gameSoundsStrings[place] = quickNSURLAsSring!
        }
        
        for button in pageButtons {
            button.enabled = true
        }
        
        for var y=0; y<6; y++ {
            var namesAsArrayOfChars = Array(setShuffled[y])
            var namesAsArrayOfCharsReadyToShow: Array<Character> = []
            var key:String = ""
            
            for char in namesAsArrayOfChars {
                if (char == "У") || (char == "Е") || (char == "А") || (char == "О") || (char == "И") || (char == "І") {
                    namesAsArrayOfCharsReadyToShow.append("_")
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
            answerLabels[y].text = setShuffled[y]
        }
    }
    
        func shallWeMoveToNextPage() {
            if gameOver() {
                
                var seconds = 2.0
                var delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
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
            let i = sender.titleLabel!.text!.toInt()!
            let objectSound = NSURL(string: gameSoundsStrings[i])
            player = AVAudioPlayer(contentsOfURL: objectSound, error: nil)
            player.prepareToPlay()
            self.player.volume = 7.9
            player.play()
            }
        default : return
        }
    }

    func animateMask() {
        
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 4
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
        let initalBounds = NSValue(CGRect: self.mask!.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 76.8*0.7, height: 102.4*0.7))
        let thirdBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 76.8*3, height: 102.4*3))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 768*2, height: 1024*2))
        keyFrameAnimation.values = [initalBounds, secondBounds, thirdBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.2, 0.4, 1]
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        self.mask!.addAnimation(keyFrameAnimation, forKey: "bounds")
    }

    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.mainScreen!.layer.mask = nil //remove mask when animation completes
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
    
    @IBAction func nextPage(sender: AnyObject) {
        
        reloadButton.enabled = false
        
        pressCounter = 0
        if activeMiniGame != nil {
            activeMiniGame.enabled = false
            activeMiniGame.highlighted = true
            leftToSolve = leftToSolve - 1
            for i in 0...5 {
                lettersButtons[i].hidden = true
            }
            testLabels[activeMiniGame.titleLabel!.text!.toInt()!].hidden = true
            answerLabels[activeMiniGame.titleLabel!.text!.toInt()!].hidden = false
            answerLabels[activeMiniGame.titleLabel!.text!.toInt()!].backgroundColor = UIColor.clearColor()
        }
        
        activePage = Int(arc4random_uniform(UInt32(12)))
        loadPage(activePage)
   
        
        var seconds = 1.0
        var delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.reloadButton.enabled = true
            
        })

    }
    
    @IBAction func startGame(sender: UIButton) {
        for i in 0..<уWords.count {
            numberOfWordsArray.append(i)
        }
        mainScreen.hidden = true
        infoButtonIcon.hidden = true
        startImageOnly.hidden = true
        startButton.hidden = true
        loadPage(activePage)
    }
    
    @IBAction func endGame(sender: UIButton) {
        
        player = AVAudioPlayer(contentsOfURL: mainTheme, error: nil)
        player.prepareToPlay()
        player.play()
        
        mainScreen.hidden = false
        infoButtonIcon.hidden = false
        startImageOnly.hidden = false
        startButton.hidden = false
        reloadButton.hidden = true
        mainMenuButton.hidden = true
        pressCounter = 0
        
        if activeMiniGame != nil {
            activeMiniGame.enabled = false
            activeMiniGame.highlighted = true
            leftToSolve = leftToSolve - 1
            for i in 0...5 {
                lettersButtons[i].hidden = true
            }
            testLabels[activeMiniGame.titleLabel!.text!.toInt()!].hidden = true
            answerLabels[activeMiniGame.titleLabel!.text!.toInt()!].hidden = false
            answerLabels[activeMiniGame.titleLabel!.text!.toInt()!].backgroundColor = UIColor.clearColor()
        }
    }
}