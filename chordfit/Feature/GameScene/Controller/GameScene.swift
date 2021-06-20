//
//  GameScene.swift
//  newConveyor
//
//  Created by Aditya Ramadhan on 10/06/21.
//

import SpriteKit
import GameplayKit

let chordSet = [
    "C": [
        "I": "C",
        "ii": "Dm",
        "iii": "Em",
        "IV": "F",
        "V": "G",
        "vi": "Am",
    ],
    "F": [
        "I": "F",
        "ii": "Gm",
        "iii": "Am",
        "IV": "Bb",
        "V": "C",
        "vi": "Dm",
    ],
    "G": [
        "I": "G",
        "ii": "Am",
        "iii": "Bm",
        "IV": "C",
        "V": "D",
        "vi": "Em",
    ]
]

var SongTime = 30


class GameScene: SKScene {
    
    var isBeginCollision: Bool = false
    
    let pauseLayer = SKNode()
    let worldNode = SKNode()
    let congratsLayer = SKNode()
    let confirmationrestartLayer = SKNode()
    let confirmationquitLayer = SKNode()
    let notCategory : UInt32 = 0x1 << 0
    let pagarCategory : UInt32 = 0x1 << 1
    let endCategory : UInt32 = 0x1 << 2
    let chordLine1Category: UInt32 = 0x1 << 3
    let chordLine2Category: UInt32 = 0x1 << 4
    let chordLine3Category: UInt32 = 0x1 << 5
    var flagpause : Bool = false
    var flagconfirm : Bool = false
    var score = 0 as Int
    var scoreNode: SKLabelNode!
    var songName : SKLabelNode!
    var artistName : SKLabelNode!
    var detailSong : SKLabelNode!
    var songKey : SKLabelNode!
    var pauseButton : SKSpriteNode!
    var newProgress = 0
    var correctChord : SKSpriteNode!
    var counterTimer = Timer()
    var songTimer : SKLabelNode = SKLabelNode()
    var renderTime : TimeInterval = 0.0
    var changeTime : TimeInterval = 1
    var seconds: Int = 0
    var minutes: Int = 0
    
    var baseKey: String = ""
    var chords: [movingCP] = []
    let songChords = [
        ["I", "3.15"],
        ["V", "3.15"],
        ["vi", "3.15"],
        ["IV", "3.15"],
        
        ["I", "3.15"],
        ["V", "3.15"],
        ["vi", "3.15"],
        ["IV", "3.15"],
        
        ["I", "3.15"],
        ["V", "3.15"],
        ["vi", "3.15"],
        ["IV", "3.15"],
        
        ["I", "3.15"],
        ["V", "3.15"],
        ["vi", "3.15"],
        ["IV", "3.15"],
        
        ["I", "3.15"],
        ["V", "3.15"],
        ["vi", "3.15"],
        ["IV", "3.15"],
    ]
    
    // PUNYA AI CHORD CLASSIFIER
    var chordClassifierViewController = ChordClassifierViewController()
    var currentBar: Int = 0
    var currentRomawi: String = ""
    var currentChord: String = ""
    
    var counter = 0
    var countertime = Timer()
    var counterstartValue = 3
    var isNotBegin : Bool = true
    var isinPause : Bool = false
    var screenOverlay  : SKSpriteNode = SKSpriteNode(imageNamed: "overlay")
    
    
    var countdownLabel : SKLabelNode = SKLabelNode()
    var countdownLayer = SKNode()
    var countdownSong : SKLabelNode = SKLabelNode()
    var songTime : Int = SongTime
    
    func makeChords(romawi : String, chord : String, time: TimeInterval){
        chords.append(movingCP(romawiDetail: romawi, chordDetail: chord, chordLong: time))
    }
    
    func readSong(songChords: [[String]]){
        for songChord in songChords {
            makeChords(romawi: songChord[0], chord: chordSet[baseKey]?[songChord[0]] ?? "X", time: TimeInterval(songChord[1]) ?? 3)
        }
    }
    
    func startCounter(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    @objc func decrementCounter(){
        if isNotBegin {
        counter -= 1
        countdownLabel.text = "\(counter)"
            if counter <= 0 {
                isNotBegin = false
                countdownLabel.isHidden = true
                flagpause = false
                screenOverlay.isHidden = true
                ResumeGame()
            }
        }
    }
    func startCounterSong(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounterSong), userInfo: nil, repeats: true)
    }
    @objc func decrementCounterSong(){
        let minutes = songTime / 60
        let seconds = songTime % 60
        var minutesText = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        var secondsText = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        if isNotBegin == false && isPaused == false{
        songTime -= 1
        songTimer.text = "\(minutesText):\(secondsText)"
            if songTime <= 0 {
                PauseGame()
                congratsLayer.isHidden = false
            }
//            if counter <= 0 {
//                isNotBegin = false
//                countdownLabel.isHidden = true
//                flagpause = false
//                screenOverlay.isHidden = true
//                ResumeGame()
//            }
//        }
        }
    }
    func gameNotBegin (){
        
    }
    func setupGame(){
        
    }
    override func didMove(to view: SKView) {
        baseKey = "C"
        readSong(songChords: songChords)
        //        let screenOverlay = SKSpriteNode(imageNamed: "overlay")
        //        screenOverlay.position = CGPoint(x: frame.midX, y: frame.midY)
        //        screenOverlay.name = "screenOverlay"
        //        addChild(screenOverlay)
                congratsLayer.isHidden = false
                addChild(congratsLayer)
                countdownLabel.zPosition = 100
                counter = counterstartValue
                screenOverlay.position = CGPoint(x: frame.midX, y: frame.midY)
                screenOverlay.zPosition = -1
                screenOverlay.isHidden = false
                addChild(screenOverlay)
                if isNotBegin == true {

//                    print("Hai")
                    PauseGame()
                    startCounter()
                    startCounterSong()
                }
                
                addChild(confirmationquitLayer)
//                print(isNotBegin)
//                print(ChordSet["C"]?["I"]!)
                var countdownArray : [SKAction] = []
                countdownLabel = SKLabelNode(fontNamed: "Arial")
                countdownLabel.fontSize = 150
                countdownLabel.zPosition = 0
                countdownLabel.text = "\(counter)"
                countdownLabel.fontColor = SKColor.white
                countdownLabel.position = CGPoint(x: frame.midX  , y: frame.midY - 50)
                addChild(countdownLabel)
                var arrayofChords : [SKAction] = []
                for n in 0...chords.count - 1  {
                    let a1 = SKAction.run {
        //                if self.chords[n].chordLong == 4
                        self.createNot4Bit(speed: 5.5, chorddetail: self.chords[n].chordDetail, progressiondetail: self.chords[n].romawiDetail)
        //                self.createNot4Bit(speed: 5.0, chorddetail: self.chords[n].chordDetail, progressiondetail: self.chords[n].romawiDetail)
                    }
                    let a2 = SKAction.wait(forDuration: self.chords[n].chordLong)
//                    print("MANTAPPP")
//                    print(self.chords[n].chordLong)
                    arrayofChords.append(a1)
                    arrayofChords.append(a2)
                }
                let a3 = SKAction.sequence(arrayofChords)
                run(a3)
                
                // Access Chord Classifier
                self.chordClassifierViewController.viewDidLoad()
        
                createBG()
        //        print("chords[0].chordDetail")
        //        countdownLabel.fontSize = 40
        //        countdownLabel.fontColor = SKColor.black
        //        countdownLabel.text = "0"
        //        countdownLabel.position  = CGPoint(x: frame.midX, y: frame.midY)
        //        addChild(countdownLabel)
                addChild(worldNode)
                addChild(pauseLayer)
                
                physicsWorld.contactDelegate = self
        //        let gambar1 = SKSpriteNode(imageNamed: "conveyor")
        //        gambar1.position = CGPoint(x:frame.midX, y: frame.midY)
        //        gambar1.zPosition = 0
        //        gambar1.size = CGSize(width: frame.size.width / 1.5, height: frame.size.width/3)
        //        addChild(gambar1)
                
                let quitLabel = SKLabelNode(fontNamed: "Arial")
                quitLabel.fontSize = 40
                quitLabel.zPosition = 21
                quitLabel.text = "Are you sure?"
                quitLabel.fontColor = SKColor.white
                quitLabel.position = CGPoint(x: frame.midX, y: frame.midY + 70)
                confirmationquitLayer.addChild(quitLabel)
                let quitMenu = SKSpriteNode(imageNamed: "confirmation")
                quitMenu.size = CGSize(width: frame.size.width - 180, height: frame.size.height/2.5)
                quitMenu.position = CGPoint(x:frame.midX, y: frame.midY - 50)
                quitMenu.zPosition = 20
                confirmationquitLayer.addChild(quitMenu)
                let yesquitBtn = SKSpriteNode(imageNamed: "confirmquit")
                yesquitBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
                yesquitBtn.position = CGPoint(x:frame.midX, y: frame.midY + -50)
                yesquitBtn.zPosition = 21
                yesquitBtn.name = "yesBtn"
                confirmationquitLayer.addChild(yesquitBtn)
                let cancelquitBtn = SKSpriteNode(imageNamed: "cancelquit")
                cancelquitBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
                cancelquitBtn.position = CGPoint(x:frame.midX, y: frame.midY + -150)
                cancelquitBtn.zPosition = 21
                cancelquitBtn.name = "cancelBtn"
                confirmationquitLayer.addChild(cancelquitBtn)
                confirmationquitLayer.isHidden = true
                
        //        let resumeBtn = SKSpriteNode(imageNamed: "resumeBtn2")
        //        resumeBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
        //        resumeBtn.position = CGPoint(x:frame.midX, y: frame.midY + 25)
        //        resumeBtn.zPosition = 11
        //        resumeBtn.name = "resumeBtn"
        //        pauseLayer.addChild(resumeBtn)
        //        let restartBtn = SKSpriteNode(imageNamed: "restartBtn2")
        //        restartBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
        //        restartBtn.position = CGPoint(x:frame.midX, y: frame.midY - 75)
        //        restartBtn.zPosition = 11
        //        restartBtn.name = "restartBtn"
        //        pauseLayer.addChild(restartBtn)
        //        let quitBtn = SKSpriteNode(imageNamed: "quitBtn2")
        //        quitBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
        //        quitBtn.position = CGPoint(x:frame.midX, y: frame.midY - 175)
        //        quitBtn.zPosition = 11
        //        pauseLayer.addChild(quitBtn)
        //        pauseLayer.isHidden = true
                
                let pauseLabel = SKLabelNode(fontNamed: "Arial")
                pauseLabel.fontSize = 40
                pauseLabel.zPosition = 11
                pauseLabel.text = "Game Paused"
                pauseLabel.fontColor = SKColor.white
                pauseLabel.position = CGPoint(x: frame.midX, y: frame.midY + 125)
                pauseLayer.addChild(pauseLabel)
                let pauseMenu = SKSpriteNode(imageNamed: "pauseMenu")
                pauseMenu.size = CGSize(width: frame.size.width - 200, height: frame.size.height/2)
                pauseMenu.position = CGPoint(x:frame.midX, y: frame.midY - 50)
                pauseMenu.zPosition = 10
                pauseLayer.addChild(pauseMenu)
                let resumeBtn = SKSpriteNode(imageNamed: "resumeBtn2")
                resumeBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
                resumeBtn.position = CGPoint(x:frame.midX, y: frame.midY + 25)
                resumeBtn.zPosition = 11
                resumeBtn.name = "resumeBtn"
                pauseLayer.addChild(resumeBtn)
                let restartBtn = SKSpriteNode(imageNamed: "restartBtn2")
                restartBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
                restartBtn.position = CGPoint(x:frame.midX, y: frame.midY - 75)
                restartBtn.zPosition = 11
                restartBtn.name = "restartBtn"
                pauseLayer.addChild(restartBtn)
                let quitBtn = SKSpriteNode(imageNamed: "quitBtn2")
                quitBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
                quitBtn.position = CGPoint(x:frame.midX, y: frame.midY - 175)
                quitBtn.zPosition = 11
                quitBtn.name = "quitBtn"
                pauseLayer.addChild(quitBtn)
                pauseLayer.isHidden = true
                let goodProgressLabel = SKLabelNode(fontNamed: "Arial")
                goodProgressLabel.fontSize = 50
                goodProgressLabel.zPosition = 11
                goodProgressLabel.text = "Good Progress!"
                goodProgressLabel.fontColor = SKColor.white
                goodProgressLabel.position = CGPoint(x: frame.midX, y: frame.midY + 125)
                congratsLayer.addChild(goodProgressLabel)
                let congratsMenu = SKSpriteNode(imageNamed: "Group81x")
                congratsMenu.size = CGSize(width: frame.size.width - 200, height: frame.size.height/2)
                congratsMenu.position = CGPoint(x:frame.midX, y: frame.midY - 50)
                congratsMenu.zPosition = 10
                congratsLayer.addChild(congratsMenu)
                congratsLayer.isHidden = true
                let starC = SKSpriteNode(imageNamed: "starC")
                starC.size = CGSize(width: starC.size.width/1.2, height: starC.size.height/1.2)
                starC.position = CGPoint(x: -150, y: 300)
                starC.zPosition = 10
                congratsMenu.addChild(starC)
                let starF = SKSpriteNode(imageNamed: "starF")
                starF.size = CGSize(width: starF.size.width/1.2, height: starF.size.height/1.2)
                starF.position = CGPoint(x: 0, y: 335)
                starF.zPosition = 10
                congratsMenu.addChild(starF)
                let starG = SKSpriteNode(imageNamed: "starG")
                starG.size = CGSize(width: starG.size.width/1.2, height: starG.size.height/1.2)
                starG.position = CGPoint(x: 150, y: 300)
                starG.zPosition = 10
                congratsMenu.addChild(starG)
                let goodrestartBtn = SKSpriteNode(imageNamed: "goodrestart")
                goodrestartBtn.size = CGSize(width: frame.size.width/2, height: frame.size.height/16)
                goodrestartBtn.position = CGPoint(x: 0, y: -100)
                goodrestartBtn.zPosition = 11
                goodrestartBtn.name = "restartBtn"
                congratsMenu.addChild(goodrestartBtn)
                let goodplayBtn = SKSpriteNode(imageNamed: "goodplay")
                goodplayBtn.size = CGSize(width: frame.size.width/2, height: frame.size.height/16)
                goodplayBtn.position = CGPoint(x: 0, y: -200)
                goodplayBtn.zPosition = 11
                goodplayBtn.name = "restartBtn"
                congratsMenu.addChild(goodplayBtn)
                congratsLayer.isHidden = true
        //        let pauseMenu = SKSpriteNode(imageNamed: "pauseMenu")
        //        pauseMenu.size = CGSize(width: frame.size.width - 200, height: frame.size.height/2)
        //        pauseMenu.position = CGPoint(x:frame.midX, y: frame.midY - 50)
        //        pauseMenu.zPosition = 10
        //        pauseLayer.addChild(pauseMenu)
        //        let resumeBtn = SKSpriteNode(imageNamed: "resumeBtn2")
        //        resumeBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
        //        resumeBtn.position = CGPoint(x:frame.midX, y: frame.midY + 25)
        //        resumeBtn.zPosition = 11
        //        resumeBtn.name = "resumeBtn"
        //        pauseLayer.addChild(resumeBtn)
        //        let restartBtn = SKSpriteNode(imageNamed: "restartBtn2")
        //        restartBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
        //        restartBtn.position = CGPoint(x:frame.midX, y: frame.midY - 75)
        //        restartBtn.zPosition = 11
        //        restartBtn.name = "restartBtn"
        //        pauseLayer.addChild(restartBtn)
        //        let quitBtn = SKSpriteNode(imageNamed: "quitBtn2")
        //        quitBtn.size = CGSize(width: frame.size.width/2.5, height: frame.size.height/16)
        //        quitBtn.position = CGPoint(x:frame.midX, y: frame.midY - 175)
        //        quitBtn.zPosition = 11
        //        quitBtn.name = "quitBtn"
        //        pauseLayer.addChild(quitBtn)
                pauseLayer.isHidden = true
        //        let pauseMenu = SKSpriteNode(imageNamed: "pauseMenu")
        //        pauseMenu.size = CGSize(width: frame.size.width - 200, height: frame.size.height/2)
        //        pauseMenu.position = CGPoint(x:frame.midX, y: frame.midY - 50)
        //        pauseMenu.zPosition = 2
        //        pauseLayer.addChild(pauseMenu)
        //        let pauseMenu = SKSpriteNode(imageNamed: "pauseMenu")
        //        pauseMenu.size = CGSize(width: frame.size.width - 200, height: frame.size.height/2)
        //        pauseMenu.position = CGPoint(x:frame.midX, y: frame.midY - 50)
        //        pauseMenu.zPosition = 2
        //        pauseLayer.addChild(pauseMenu)
                
                
        //        let conveyor = SKSpriteNode(imageNamed: "conveyor")
        //        conveyor.position = CGPoint(x:frame.midX - 25, y: frame.midY - 200)
        //        conveyor.size = CGSize(width: frame.size.width , height: frame.size.height/5.3)
        //        conveyor.zPosition = 0
        //        worldNode.addChild(conveyor)
        //        let conveyor = SKSpriteNode(imageNamed: "conveyor")
        //        conveyor.position = CGPoint(x:frame.midX - 25, y: frame.midY - 200)
        //        conveyor.size = CGSize(width: frame.size.width , height: frame.size.height/5.3)
        //        conveyor.zPosition = 0
        //        worldNode.addChild(conveyor)
                
                let conveyor = SKSpriteNode(imageNamed: "conveyor")
                conveyor.position = CGPoint(x:frame.midX - 25, y: frame.midY - 200)
                conveyor.size = CGSize(width: frame.size.width , height: frame.size.height/5.3)
                conveyor.zPosition = -1
                addChild(conveyor)
                
                correctChord = SKSpriteNode(imageNamed: "correctChord")
                correctChord.position = CGPoint(x:frame.midX - 25, y: frame.midY - 200)
                correctChord.size = CGSize(width: frame.size.width , height: frame.size.height/5.3)
                correctChord.zPosition = 1
                correctChord.isHidden = true
                worldNode.addChild(correctChord)
                let microphone = SKSpriteNode(imageNamed: "mic")
                microphone.position = CGPoint(x:frame.midX, y: frame.midY - 400)
        //        microphone.size = CGSize(width: frame.size.width , height: frame.size.height/5.3)
                microphone.zPosition = 0
                worldNode.addChild(microphone)
                
        //        pauseButton = SKSpriteNode(imageNamed: <#T##String#>)
                
                createsongsDetail(songname: "Unholy Confession ", artistname: "Avenged Sevenfold", detailsong: "Rock - 183 bpm", songkey:"C")
                score = 0
                scoreNode = SKLabelNode(fontNamed: "Arial")
                scoreNode.fontSize = 25
                scoreNode.zPosition = 0
                scoreNode.text = "0 / 10"
                scoreNode.fontColor = SKColor.white
                scoreNode.position = CGPoint(x: frame.midX + 255, y: frame.maxY - 595)
                addChild(scoreNode)
                let progressionNode = SKLabelNode(fontNamed: "Arial")
                progressionNode.fontSize = 25
                progressionNode.zPosition = 0
                progressionNode.text = "I"
                progressionNode.fontColor = SKColor.white
                progressionNode.position = CGPoint(x: frame.midX - 245, y: frame.maxY - 592)
                addChild(progressionNode)
                
                songTimer = SKLabelNode(fontNamed: "Arial")
                songTimer.fontSize = 30
                songTimer.zPosition = -1
                songTimer.text = "00:00"
                songTimer.fontColor = SKColor.white
                songTimer.position = CGPoint(x: frame.midX - 225 , y: frame.midY - 50)
                addChild(songTimer)
                
                
                
                
                let garis = SKSpriteNode(imageNamed: "linefit")
                garis.position = CGPoint(x:frame.minX + 150 , y: frame.midY - 200   )
                garis.zPosition = 2
                garis.physicsBody = SKPhysicsBody(circleOfRadius: garis.size.width / 2.0)
                garis.size = CGSize(width: garis.size.width, height: frame.size.width/3.2)
                garis.physicsBody?.affectedByGravity = false
                garis.physicsBody?.isDynamic = false
                garis.physicsBody?.categoryBitMask = pagarCategory
                addChild(garis)
                
                let pauseButton = SKSpriteNode(imageNamed: "paused")
                pauseButton.position = CGPoint(x:frame.maxX - 150 , y: frame.maxY - 150  )
                pauseButton.name = "pauseBtn"
                pauseButton.zPosition = 10
                addChild(pauseButton)
//                print(isNotBegin)
        
    }
        
    override func update(_ currentTime: TimeInterval) {
//        if currentTime > renderTime{
//            if renderTime > 0 {
//                seconds += 1
//                if seconds == 60     {
//                    seconds = 0
//                    minutes += 1
//                }
//            songTimer.text = "\(minutes) : \(seconds)"
//            }
//            renderTime = currentTime+changeTime
//        }
    }
    
    func createsongsDetail(songname:String, artistname :String, detailsong:String, songkey:String){
//        let detailSongLayer = SKSpriteNode(imageNamed: "detailRect")
//        detailSongLayer.size = CGSize(width: frame.size.width/2, height: frame.size.height/4)
//        detailSongLayer.position = CGPoint(x: frame.midX - 100, y: frame.maxY - 200)
//        detailSongLayer.anchorPoint = CGPoint(x: 0, y: 0)
//        addChild(detailSongLayer)
        songName = SKLabelNode(fontNamed: "Arial")
        songName.fontSize = 40
        songName.zPosition = 2
        songName.text = "\(songname)"
        songName.zPosition = 2
        songName.fontColor = SKColor.black
        songName.position = CGPoint(x: 150, y: 50)
        songName.position = CGPoint(x: frame.minX + 260, y: frame.maxY - 120)
        addChild(songName)
        
       
        
        artistName = SKLabelNode(fontNamed: "Arial")
//        artistName.makeTextWritingDirectionLeftToRight(self)
        artistName.fontSize = 30
        artistName.zPosition = 2
        artistName.text = "\(artistname)"
        artistName.position = CGPoint(x: frame.minX  + 220 , y: frame.maxY - 160)
        artistName.fontColor = SKColor.black
//        artistName.horizontalAlignmentMode = .left
        addChild(artistName)
        detailSong = SKLabelNode(fontNamed: "Arial")
        detailSong.fontSize = 25
        detailSong.zPosition = 2
        detailSong.text = "\(detailsong)"
        detailSong.fontColor = SKColor.black
        detailSong.position = CGPoint(x: frame.minX + 180, y: frame.maxY - 210)
        addChild(detailSong)
        songKey = SKLabelNode(fontNamed: "Arial")
        songKey.fontSize = 25
        songKey.zPosition = 2
        songKey.text = "Key : \(songkey)"
        songKey.fontColor = SKColor.black
        songKey.position = CGPoint(x: frame.minX + 135, y: frame.maxY - 250)
        addChild(songKey)
//        songName = SKLabelNode(fontNamed: "Arial")
//        songName.fontSize = 40
//        songName.zPosition = 2
//        songName.text = "\(songname)"
//        songName.fontColor = SKColor.black
//        songName.position = CGPoint(x: frame.minX + 260, y: frame.maxY - 130)
//        addChild(songName)
//        songName = SKLabelNode(fontNamed: "Arial")
//        songName.fontSize = 40
//        songName.zPosition = 2
//        songName.text = "Avenged Sevenfold"
//        songName.fontColor = SKColor.black
//        songName.position = CGPoint(x: frame.minX + 260, y: frame.maxY - 130)
//        addChild(songName)
    }
    
    func addProgress(progressLevel : Int){
        let bground = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frame.size.width/2, height: 50))
        bground.fillColor = .white
        bground.position = CGPoint(x: frame.midX - frame.size.width/3.6 , y: frame.maxY - 400)
        bground.zPosition = -2
        addChild(bground)
//        print(bground.frame.width)
        bground.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -200, width: frame.size.width/1.8, height: 35), cornerRadius: 50).cgPath
//        print(bground.frame.width)
        let round = SKShapeNode(rect: CGRect(x: 0, y: -150, width: 500, height: 35))
        round.fillColor = #colorLiteral(red: 1, green: 0.7857890725, blue: 0, alpha: 1)
        round.position = CGPoint(x: frame.midX - frame.size.width/3.6 , y: frame.maxY - 400)
        round.zPosition = -2
        addChild(round)
//        print(round.frame.width)
        round.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -200, width: progressLevel, height: 35), cornerRadius: 50).cgPath
//        print(round.frame.width)
    }
    
    func createNot2Bit(speed : Double, chorddetail : String , progressiondetail : String){
//        progressionDetail.position = CGPoint(x: frame.minX + 180, y: frame.maxY - 130)
//        addChild(songName)
        let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 100, y: frame.midY - 195), duration: speed)
        let gambar = SKSpriteNode(imageNamed: "movingCP")
        gambar.position = CGPoint(x:frame.maxX + 80, y: frame.midY - 195)
        gambar.zPosition = 2
        gambar.size = CGSize(width: frame.size.width/2.4, height: frame.size.width/6)
        gambar.physicsBody = SKPhysicsBody (circleOfRadius: gambar.size.width / 6)
//        gambar.name = "not"
//        gambar.physicsBody?.categoryBitMask = notCategory
//        gambar.physicsBody?.contactTestBitMask = pagarCategory
        gambar.physicsBody?.collisionBitMask = .zero
        gambar.name = "Not"
        gambar.run(moveBottomLeft, withKey: "gerakKiri")
        gambar.physicsBody?.affectedByGravity = false
        let progressionLine = SKSpriteNode(imageNamed: "chordline")
        progressionLine.position = CGPoint(x: 0, y: -5.5)
        progressionLine.zPosition = -1
        progressionLine.size = CGSize(width: progressionLine.size.width, height: frame.size.height/5.6)
        progressionLine.physicsBody = SKPhysicsBody (circleOfRadius: progressionLine.size.width / 2)
        progressionLine.name = "progressionLine"
        progressionLine.physicsBody?.categoryBitMask = notCategory
        progressionLine.physicsBody?.contactTestBitMask = pagarCategory
        progressionLine.physicsBody?.collisionBitMask = .zero
        progressionLine.physicsBody?.affectedByGravity = false
        let endLine = SKSpriteNode(imageNamed: "chordline")
        endLine.position = CGPoint(x: gambar.size.width/2, y: -5.5)
        endLine.zPosition = -4
        endLine.size = CGSize(width: progressionLine.size.width, height: frame.size.height/5.6)
        endLine.physicsBody = SKPhysicsBody (circleOfRadius: progressionLine.size.width / 2)
        endLine.name = "progressionLine"
        endLine.physicsBody?.categoryBitMask = endCategory
        endLine.physicsBody?.contactTestBitMask = pagarCategory
        endLine.physicsBody?.collisionBitMask = .zero
        endLine.physicsBody?.affectedByGravity = false
        let progressionDetail = SKLabelNode(fontNamed: "arial")
        progressionDetail.fontSize = 60
        progressionDetail.zPosition = 2
        progressionDetail.text = progressiondetail
        progressionDetail.fontColor = SKColor.white
        progressionDetail.position = CGPoint(x: -90 , y: -20)
        let chordDetail = SKLabelNode(fontNamed: "arial")
        chordDetail.fontSize = 60
        chordDetail.zPosition = 2
        chordDetail.text = chorddetail
        chordDetail.fontColor = SKColor.white
        chordDetail.position = CGPoint(x: 90 , y: -20)
        let movingProg = SKSpriteNode(imageNamed: "movingProg")
        let movingProgWidth = movingProg.texture?.size().width
        let movingProgHeight = movingProg.texture?.size().height
        movingProg.zPosition = 3
        movingProg.position = CGPoint(x: -90, y: 0)
        movingProg.size = CGSize(width: (movingProgWidth ?? 0 ) * 1.6, height: (movingProgHeight ?? 0)*1.6)
        progressionDetail.position = CGPoint(x: -2 , y: -22)
        gambar.addChild(movingProg)
        gambar.addChild(chordDetail)
        gambar.addChild(endLine)
        movingProg.addChild(progressionDetail)
        movingProg.addChild(progressionLine)
        addChild(gambar)
    }
    func createNot4Bit(speed : Double, chorddetail : String , progressiondetail : String){
//        progressionDetail.position = CGPoint(x: frame.minX + 180, y: frame.maxY - 130)
//        addChild(songName)
        let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 300, y: frame.midY - 195), duration: speed)
        let gambar = SKSpriteNode(imageNamed: "chordlong1x")
        gambar.position = CGPoint(x:frame.maxX + 280, y: frame.midY - 195)
        gambar.zPosition = 2
        gambar.size = CGSize(width: gambar.size.width/1.35  , height: gambar.size.height/1.35)
        gambar.physicsBody = SKPhysicsBody (circleOfRadius: gambar.size.width / 6)
//        gambar.name = "not"
//        gambar.physicsBody?.categoryBitMask = notCategory
//        gambar.physicsBody?.contactTestBitMask = pagarCategory
        gambar.physicsBody?.collisionBitMask = .zero
        gambar.name = "Not"
        gambar.run(moveBottomLeft, withKey: "gerakKiri")
        gambar.physicsBody?.affectedByGravity = false
        
        
        // Begin and End Line
        let progressionLine = SKSpriteNode(imageNamed: "chordline")
        progressionLine.position = CGPoint(x: 0, y: -5.5)
        progressionLine.zPosition = -1
        progressionLine.size = CGSize(width: progressionLine.size.width, height: frame.size.height/5.6)
        progressionLine.physicsBody = SKPhysicsBody (circleOfRadius: progressionLine.size.width / 2)
        progressionLine.name = "progressionLine"
        progressionLine.physicsBody?.categoryBitMask = notCategory
        progressionLine.physicsBody?.contactTestBitMask = pagarCategory
        progressionLine.physicsBody?.collisionBitMask = .zero
        progressionLine.physicsBody?.affectedByGravity = false
        let endLine = SKSpriteNode(imageNamed: "chordline")
        endLine.position = CGPoint(x: gambar.size.width / 2, y: -5.5)
        endLine.zPosition = -4
        endLine.size = CGSize(width: endLine.size.width, height: frame.size.height/5.6)
        endLine.physicsBody = SKPhysicsBody (circleOfRadius: progressionLine.size.width / 2)
        endLine.name = "endLine"
        endLine.physicsBody?.categoryBitMask = endCategory
        endLine.physicsBody?.contactTestBitMask = pagarCategory
        endLine.physicsBody?.collisionBitMask = .zero
        endLine.physicsBody?.affectedByGravity = false
        
        // Garis setiap kali detect chord
        let chordLine1 = createLine(x: -(gambar.size.width - 125) / 4,
                                    y: 0,
                                    z: 2,
                                    width: endLine.size.width,
                                    height: frame.size.height/5.6,
                                    circleOfRadius: progressionLine.size.width / 2,
                                    name: "chordLine1",
                                    categoryBitMask: chordLine1Category,
                                    contactTestBitMask: pagarCategory)
        chordLine1.physicsBody?.categoryBitMask = chordLine1Category
        let chordLine2 = createLine(x: 0,
                                    y: 0,
                                    z: 2,
                                    width: endLine.size.width,
                                    height: frame.size.height/5.6,
                                    circleOfRadius: progressionLine.size.width / 2,
                                    name: "chordLine2",
                                    categoryBitMask: chordLine2Category,
                                    contactTestBitMask: pagarCategory)
        let chordLine3 = createLine(x: (gambar.size.width - 125) / 4,
                                    y: 0,
                                    z: 2,
                                    width: endLine.size.width,
                                    height: frame.size.height/5.6,
                                    circleOfRadius: progressionLine.size.width / 2,
                                    name: "chordLine3",
                                    categoryBitMask: chordLine3Category,
                                    contactTestBitMask: pagarCategory)
        
        let progressionDetail = SKLabelNode(fontNamed: "arial")
        progressionDetail.fontSize = 60
        progressionDetail.zPosition = 2
        progressionDetail.text = progressiondetail
        progressionDetail.fontColor = SKColor.white
        progressionDetail.position = CGPoint(x: -300 , y: -20)
        let chordDetail = SKLabelNode(fontNamed: "arial")
        chordDetail.fontSize = 60
        chordDetail.zPosition = 2
        chordDetail.text = chorddetail
        chordDetail.fontColor = SKColor.white
        chordDetail.position = CGPoint(x: 250 , y: -20)
        let movingProg = SKSpriteNode(imageNamed: "movingProg")
        let movingProgWidth = movingProg.texture?.size().width
        let movingProgHeight = movingProg.texture?.size().height
        movingProg.zPosition = 3
        movingProg.position = CGPoint(x: -260, y: 0)
        movingProg.size = CGSize(width: (movingProgWidth ?? 0 ) * 1.6, height: (movingProgHeight ?? 0)*1.6)
        progressionDetail.position = CGPoint(x: -2 , y: -22)
        gambar.addChild(movingProg)
        gambar.addChild(chordDetail)
        gambar.addChild(endLine)
        gambar.addChild(chordLine1)
        gambar.addChild(chordLine2)
        gambar.addChild(chordLine3)
        movingProg.addChild(progressionDetail)
        movingProg.addChild(progressionLine)
        addChild(gambar)
    }
    
    func createLine(x: CGFloat, y: CGFloat, z: CGFloat, width: CGFloat, height: CGFloat, circleOfRadius: CGFloat, name: String, categoryBitMask: UInt32, contactTestBitMask: UInt32) -> SKSpriteNode {
        
        let line = SKSpriteNode(imageNamed: "chordline")
        line.position = CGPoint(x: x, y: y)
        line.zPosition = z
        line.size = CGSize(width: width, height: height)
        line.physicsBody = SKPhysicsBody (circleOfRadius: circleOfRadius)
        line.name = name
        line.physicsBody?.categoryBitMask = categoryBitMask
        line.physicsBody?.contactTestBitMask = contactTestBitMask
        line.physicsBody?.collisionBitMask = .zero
        line.physicsBody?.affectedByGravity = false
        
        return line
    }
    
    func createBG(){
        let bg = SKSpriteNode()
        bg.texture = SKTexture (imageNamed: "rect")
        bg.size = CGSize(width: frame.size.width, height: frame.size.height)
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        bg.zPosition = -4
        addChild(bg)
        let whitebg = SKSpriteNode()
        whitebg.texture = SKTexture (imageNamed: "whiteback")
        whitebg.size = CGSize(width: frame.size.width/1.1  , height: frame.size.height/2.5)
        whitebg.position = CGPoint(x: frame.midX, y: frame.maxY-120)
        whitebg.zPosition = -3
        addChild(whitebg)
    }
    
//    func songsDetail(){
//        let songName = SKLabelNode(fontNamed: "Arial")
//        songName.fontSize = 30
//        songName.text = "Avenged Sevenfold"
//        songName.position = CGPoint(x: frame.minX + 100, y: frame.maxY - 200)
//        songName.zPosition = 0
//        songName.fontColor = SKColor.black
//        addChild(songName)
//    }
    
    func PauseGame(){
        self.isPaused = true
    }
    func ResumeGame(){
        self.isPaused = false
    }
    
   
    
}

extension GameScene : SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
       
        var arrayofChords : [SKAction] = []
        let collision : UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let endcollision : UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
//        let a1 = SKAction.run {
//            self.correctChord.isHidden = false
//        }
//        let a2 = SKAction.wait(forDuration: 1.6)
//        let a3 = SKAction.run {
//            self.correctChord.isHidden = true
//        }
//        arrayofChords.append(a1)
//        arrayofChords.append(a2)
//        arrayofChords.append(a3)
//        let a4 = SKAction.sequence(arrayofChords)
        if collision == notCategory | pagarCategory{
//            run(a4)
            self.isBeginCollision = true
            self.correctChord.isHidden = true
            print("Collision Occured")

            // Update Current Beat
            currentBar += 1
            print("Bar: \(currentBar)")

            // Update Current Chord
            currentRomawi = songChords[currentBar-1][0]
            currentChord = chordSet[baseKey]?[currentRomawi] ?? "X"
            print("Chord:\(currentChord)")
            self.chordClassifierViewController.currentChord = currentChord
//            self.chordClassifierViewController.realChord = { currentChord in
//                return currentChord
//            }

            // Start Audio Engine and Recording
            self.chordClassifierViewController.startAudioEngine()

            if score < 10 {
                score += 1
                scoreNode.text = "\(score) / 10"
    //            PauseGame()
                addProgress(progressLevel: 42 + newProgress)
                newProgress += 42
            }else{
//                congratsLayer.isHidden = false
                self.chordClassifierViewController.stopAudioEngine()
                print(self.chordClassifierViewController.identified)
            }
        }
        
        if collision == chordLine1Category | pagarCategory {
            print("1ST CHORD LINE")
            
            if self.chordClassifierViewController.isCorrectChord == true {
                print("BENER DI 1")
                self.correctChord.isHidden = false
            }
        }else if collision == chordLine2Category | pagarCategory {
            print("2ND CHORD LINE")
            
            if self.chordClassifierViewController.isCorrectChord == true {
                print("BENER DI 2")
                self.correctChord.isHidden = false
            }
        } else if collision == chordLine3Category | pagarCategory {
            print("3RD CHORD LINE")
            
            if self.chordClassifierViewController.isCorrectChord == true {
                print("BENER DI 3")
                self.correctChord.isHidden = false
            }
        }
        
        if collision == endCategory | pagarCategory {
            print("KENA KAUUU")
            self.isBeginCollision = false
            
            self.correctChord.isHidden = true
            self.chordClassifierViewController.stopAudioEngine()
            print(self.chordClassifierViewController.identified)
            
            if self.chordClassifierViewController.isCorrectChord == true {
                self.correctChord.isHidden = false
            } else {
                self.correctChord.isHidden = true
            }
            
        }
        
//        if isBeginCollision == true {
////            print("BELOM SELESAI WOI")
//            if self.chordClassifierViewController.isCorrectChord == true {
//                print("MANTAB UDAH BENER, chordnya: \(currentChord)")
//                self.correctChord.isHidden = false
//            }
//        }
        
    }

        
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {return}
//        let location = touch.location(in: self)
//        let objects = nodes(at: location)
//
//        if objects.contains(pauseButton){
//            PauseGame()
//        }
//          for touch in touches
//           {
//               let location = touch.location(in: self)
//
//               if died == true
//               {
//                   if restartBTN.contains(location) {
//                   restartScene()
//                   }
//               }
//
//               if pauseBTN.contains(location) {
//                   print(pause)
//                   createunPauseBTN()
//                   print("asd")
//                   pauseBTN.removeFromParent()
//                   pauseGame()
//               }
//        }
        for touch: AnyObject in touches {
                let pointOfTouch = touch.location(in: self)
                let pointOfTouchPause = touch.location(in: self.pauseLayer)
                let nodeUserTapped = atPoint(pointOfTouch)
                let nodeUserTappedOnPause = atPoint(pointOfTouchPause)
                if nodeUserTapped.name == "pauseBtn" {
                    if flagpause == false {
                        if (self.isPaused == false) {
                            screenOverlay.isHidden = false
                            isinPause = true
                            flagpause = true
                            PauseGame()
                            pauseLayer.isHidden = false
                            }
                    }
                    }
            if nodeUserTapped.name == "resumeBtn"{
                counter = counterstartValue
                countdownLabel.text = "\(counter)"
//                print("halo")
                countdownLabel.isHidden = false
                pauseLayer.isHidden = true
                isNotBegin = true
//                if isinPause == true{
//                    PauseGame()
//                    startCounter()
//                }
//                startCounter()
//                ResumeGame()
//                flagpause = false
                }
            if nodeUserTapped.name == "quitBtn"{
//                print("halo")
                confirmationquitLayer.isHidden = false
                flagconfirm = true
                }
            if nodeUserTapped.name == "cancelBtn"{
//                print("Halo")
                confirmationquitLayer.isHidden = true
            }
            if nodeUserTapped.name == "restartBtn"{
//                print("Halo")
                self.removeAllChildren()
                self.removeAllActions()
                self.scene?.removeFromParent()
                let gameScene = GameScene(size: self.size)
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene)
            }
            }
            
            
        
        }
}



