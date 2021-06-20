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

class GameScene: SKScene {
    
    let pauseLayer = SKNode()
    let worldNode = SKNode()
    let congratsLayer = SKNode()
    let confirmationrestartLayer = SKNode()
    let confirmationquitLayer = SKNode()
    let notCategory : UInt32 = 0x1 << 0
    let pagarCategory : UInt32 = 0x1 << 1
    let endCategory : UInt32 = 0x1 << 2
    let gambarCategory : UInt32 = 0x1 << 6
    let chordLine1Category: UInt32 = 0x1 << 3
    let chordLine2Category: UInt32 = 0x1 << 4
    let chordLine3Category: UInt32 = 0x1 << 5
    var flagpause : Bool = false
    var flagconfirm : Bool = false
    var score = 0 as Int
    var lastscore = 0 as Int
    var scoreNode: SKLabelNode!
    var songName : SKLabelNode!
    var artistName : SKLabelNode!
    var detailSong : SKLabelNode!
    var songKey : SKLabelNode!
    var pauseButton : SKSpriteNode!
    var lastprogressBar: SKShapeNode!
    var lastprogressBarBg: SKShapeNode!
    var lastprogressNode: SKLabelNode!
    var feedbackLabel: SKLabelNode!
    
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
    let song: Song?
//    let songChords: [[String]] = [
//        ["I", "2.6"],
//        ["V", "2.6"],
//        ["vi", "2.6"],
//        ["IV", "2.6"],
//
//        ["I", "2.6"],
//        ["V", "2.6"],
//        ["vi", "2.6"],
//        ["IV", "2.6"],
//
//        ["I", "2.6"],
//        ["V", "2.6"],
//        ["vi", "2.6"],
//        ["IV", "2.6"],
//
//        ["I", "2.6"],
//        ["V", "2.6"],
//        ["vi", "2.6"],
//        ["IV", "2.6"],
//
//        ["I", "2.6"],
//        ["V", "2.6"],
//        ["vi", "2.6"],
//        ["IV", "2.6"],
//
//        ["I", "2.6"],
//        ["V", "2.6"],
//        ["vi", "2.6"],
//        ["IV", "2.6"],
//
//        ["I", "2.6"],
//        ["V", "2.6"],
//        ["vi", "2.6"],
//        ["IV", "2.6"]
//    ]
    
    // PUNYA AI CHORD CLASSIFIER
    var chordClassifierViewController = ChordClassifierViewController()
    var currentBar: Int = 0
    var currentRomawi: String = ""
    var currentChord: String = ""
    
    // PUNYA AUDIO PLAYER
    var audioPlayerController = AudioPlayerController()
    var audioFileName: String = "Imagine Dragons - Demons Audio"
    
    var counter = 0
    var countertime = Timer()
    var counterstartValue = 3
    var isNotBegin : Bool = true
    var isinPause : Bool = false
    var screenOverlay  : SKSpriteNode = SKSpriteNode(imageNamed: "overlay")
    
    var countdownLabel : SKLabelNode = SKLabelNode()
    var countdownLayer = SKNode()
    var countdownSong : SKLabelNode = SKLabelNode()
    var songTime : Int = 0
    
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
                resumeGame()
                
                audioPlayerController.playAudio(filename: audioFileName)
            }
        }
    }
    
    func getAudioDuration() -> Int {
        let duration = self.audioPlayerController.getAudioDuration(filename: audioFileName)
        let durationInt = Int(duration) + 1
        
        return durationInt
    }
    
    func startCounterSong(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounterSong), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounterSong(){
        let minutes = songTime / 60
        let seconds = songTime % 60
        let minutesText = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsText = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        if isNotBegin == false && isPaused == false{
        songTime -= 1
        songTimer.text = "\(minutesText):\(secondsText)"
            if songTime <= 0 {
                pauseGame()
                congratsLayer.isHidden = false
            }
        }
    }
    
    func gameNotBegin() {
        
    }
    
    func setupGame() {
        
    }
    
    // MARK: - didMove
    
    override func didMove(to view: SKView) {
        
        let bground = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frame.size.width/2, height: 50))
        bground.fillColor = .white
        bground.position = CGPoint(x: frame.midX - frame.size.width/3.6 , y: frame.maxY - 400)
        bground.zPosition = -3
        bground.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -200, width: frame.size.width/1.8, height: 35), cornerRadius: 50).cgPath
        addChild(bground)
        print(bground.frame.width)
        
        // Set Song
        baseKey = "C"
        readSong(songChords: songChords)
        songTime = getAudioDuration()
        
        congratsLayer.isHidden = false
        addChild(congratsLayer)
        countdownLabel.zPosition = 100
        counter = counterstartValue
        screenOverlay.position = CGPoint(x: frame.midX, y: frame.midY)
        screenOverlay.zPosition = -1
        screenOverlay.isHidden = false
        addChild(screenOverlay)
        if isNotBegin == true {
            pauseGame()
            startCounter()
            startCounterSong()
        }
                
        addChild(confirmationquitLayer)
        
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
                self.createNot4Bit(speed: 5, chorddetail: self.chords[n].chordDetail, progressiondetail: self.chords[n].romawiDetail)
            }
            let a2 = SKAction.wait(forDuration: self.chords[n].chordLong)
            arrayofChords.append(a1)
            arrayofChords.append(a2)
        }
        let a3 = SKAction.sequence(arrayofChords)
        run(a3)
                
        // Access Chord Classifier
        self.chordClassifierViewController.viewDidLoad()
        
        createBG()
        
        addChild(worldNode)
        addChild(pauseLayer)
                
        physicsWorld.contactDelegate = self
                
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
        
        let congratsMenu = SKSpriteNode(imageNamed: "Group81x")
        congratsMenu.size = CGSize(width: frame.size.width - 200, height: frame.size.height/2)
        congratsMenu.position = CGPoint(x:frame.midX, y: frame.midY - 50)
        congratsMenu.zPosition = 10
        congratsLayer.addChild(congratsMenu)
        congratsLayer.isHidden = true
        lastprogressBar = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 500, height: 35))
        lastprogressBar.fillColor = #colorLiteral(red: 1, green: 0.7857890725, blue: 0, alpha: 1)
        lastprogressBar.position = CGPoint(x: -175, y:0)
        lastprogressBar.zPosition = 14
        lastprogressBarBg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 500, height: 35))
        lastprogressBarBg.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lastprogressBarBg.position = CGPoint(x: -175, y:0)
        lastprogressBarBg.zPosition = 13
        lastprogressBarBg.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 350, height: 35), cornerRadius: 50).cgPath
        lastprogressNode = SKLabelNode(fontNamed: "Arial")
        lastprogressNode.fontSize = 25
        lastprogressNode.zPosition = 12
        lastprogressNode.text = "0/10"
        lastprogressNode.fontColor = SKColor.white
        lastprogressNode.position = CGPoint(x: frame.midX + 210, y: frame.midY + 10)
        congratsMenu.addChild(lastprogressBarBg)
        congratsMenu.addChild(lastprogressNode)
        congratsMenu.addChild(lastprogressBar)
        
        let goodProgressLabel = SKLabelNode(fontNamed: "Arial")
        goodProgressLabel.fontSize = 50
        goodProgressLabel.zPosition = 11
        goodProgressLabel.text = "Good Progress!"
        goodProgressLabel.fontColor = SKColor.white
        goodProgressLabel.position = CGPoint(x: frame.midX, y: frame.midY + 125)
        congratsMenu.addChild(goodProgressLabel)
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
        
        pauseLayer.isHidden = true
                
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
        microphone.zPosition = 0
        worldNode.addChild(microphone)
        
        createSongsDetail(songname: "Demons ", artistname: "Imagine Dragons", detailsong: "Pop - 148 bpm", songkey:"C")
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
                
        feedbackLabel = SKLabelNode(fontNamed: "Arial")
        feedbackLabel.fontSize = 30
        feedbackLabel.zPosition = -1
        feedbackLabel.text = "CORRECT!"
        feedbackLabel.fontColor = SKColor.white
        feedbackLabel.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        feedbackLabel.isHidden = true
        addChild(feedbackLabel)
                
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
        
    }
        
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func createSongsDetail(songname:String, artistname :String, detailsong:String, songkey:String){

        songName = SKLabelNode(fontNamed: "Arial")
        songName.fontSize = 40
        songName.zPosition = 2
        songName.text = "\(songname)"
        songName.zPosition = 2
        songName.fontColor = SKColor.black
        songName.position = CGPoint(x: 150, y: 50)
        songName.position = CGPoint(x: frame.minX + 180, y: frame.maxY - 120)
        addChild(songName)
        
        artistName = SKLabelNode(fontNamed: "Arial")
        artistName.fontSize = 30
        artistName.zPosition = 2
        artistName.text = "\(artistname)"
        artistName.position = CGPoint(x: frame.minX  + 170 , y: frame.maxY - 160)
        artistName.fontColor = SKColor.black
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

    }
    
    func addProgress(progressLevel : Int){
        
        let round = SKShapeNode(rect: CGRect(x: 0, y: -150, width: 500, height: 35))
        round.fillColor = #colorLiteral(red: 1, green: 0.7857890725, blue: 0, alpha: 1)
        round.position = CGPoint(x: frame.midX - frame.size.width/3.6 , y: frame.maxY - 400)
        round.zPosition = -2
        addChild(round)
        round.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -200, width: progressLevel, height: 35), cornerRadius: 50).cgPath
        
    }
    
    func createNot2Bit(speed : Double, chorddetail : String , progressiondetail : String){
        
        let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 100, y: frame.midY - 195), duration: speed)
        let gambar = SKSpriteNode(imageNamed: "movingCP")
        gambar.position = CGPoint(x:frame.maxX + 80, y: frame.midY - 195)
        gambar.zPosition = 2
        gambar.size = CGSize(width: frame.size.width/2.4, height: frame.size.width/6)
        gambar.physicsBody = SKPhysicsBody (circleOfRadius: gambar.size.width / 6)
        gambar.physicsBody?.collisionBitMask = .zero
        gambar.name = "Not"
        gambar.run(moveBottomLeft, withKey: "gerakKiri")
        gambar.physicsBody?.affectedByGravity = false
        
        // Begin and End Line
        let progressionLine = SKSpriteNode(imageNamed: "chordline")
        setupLine(line: progressionLine,
                  x: 0, y: -5.5, z: -1,
                  width: progressionLine.size.width, height: frame.size.height/5.6,
                  circleOfRadius: progressionLine.size.width / 2,
                  name: "progressionLine",
                  categoryBitMask: notCategory,
                  contactTestBitMask: pagarCategory)
        
        let endLine = SKSpriteNode(imageNamed: "chordline")
        setupLine(line: endLine,
                  x: gambar.size.width / 2, y: -5.5, z: -4,
                  width: endLine.size.width, height: frame.size.height/5.6,
                  circleOfRadius: progressionLine.size.width / 2,
                  name: "endLine",
                  categoryBitMask: endCategory,
                  contactTestBitMask: pagarCategory)
        
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
        
        let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 300, y: frame.midY - 195), duration: speed)
        let gambar = SKSpriteNode(imageNamed: "chordlong1x")
        gambar.position = CGPoint(x:frame.maxX + 280, y: frame.midY - 195)
        gambar.zPosition = 2
        gambar.size = CGSize(width: gambar.size.width/1.35  , height: gambar.size.height/1.35)
        gambar.physicsBody = SKPhysicsBody (circleOfRadius: gambar.size.width / 6)
        gambar.physicsBody?.collisionBitMask = .zero
        gambar.name = "Not"
        gambar.run(moveBottomLeft, withKey: "gerakKiri")
        gambar.physicsBody?.collisionBitMask = .zero
        gambar.physicsBody?.affectedByGravity = false
        
        
        // Begin and End Line
        let progressionLine = SKSpriteNode(imageNamed: "chordline")
        setupLine(line: progressionLine,
                  x: 0, y: -5.5, z: -1,
                  width: progressionLine.size.width, height: frame.size.height/5.6,
                  circleOfRadius: progressionLine.size.width / 2,
                  name: "progressionLine",
                  categoryBitMask: notCategory,
                  contactTestBitMask: pagarCategory)
        
        let endLine = SKSpriteNode(imageNamed: "chordline")
        setupLine(line: endLine,
                  x: gambar.size.width / 2, y: -5.5, z: -4,
                  width: endLine.size.width, height: frame.size.height/5.6,
                  circleOfRadius: progressionLine.size.width / 2,
                  name: "endLine",
                  categoryBitMask: endCategory,
                  contactTestBitMask: pagarCategory)
        
        // Garis setiap kali detect chord
        let chordLine1 = SKSpriteNode(imageNamed: "chordline")
        setupLine(line: chordLine1,
                  x: -(gambar.size.width - 125) / 4, y: 0, z: -4,
                  width: endLine.size.width, height: frame.size.height/5.6,
                  circleOfRadius: 30,
                  name: "chordLine1",
                  categoryBitMask: chordLine1Category,
                  contactTestBitMask: pagarCategory)
        
        let chordLine2 = SKSpriteNode(imageNamed: "chordline")
        setupLine(line: chordLine2,
                  x: 0, y: 0, z: -4,
                  width: endLine.size.width, height: frame.size.height/5.6,
                  circleOfRadius: 30,
                  name: "chordLine2",
                  categoryBitMask: chordLine2Category,
                  contactTestBitMask: pagarCategory)
        
        let chordLine3 = SKSpriteNode(imageNamed: "chordline")
        setupLine(line: chordLine3,
                  x: (gambar.size.width - 125) / 4, y: 0, z: -4,
                  width: endLine.size.width, height: frame.size.height/5.6,
                  circleOfRadius: 30,
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
    
    func setupLine(line: SKSpriteNode, x: CGFloat, y: CGFloat, z: CGFloat, width: CGFloat, height: CGFloat, circleOfRadius: CGFloat, name: String, categoryBitMask: UInt32, contactTestBitMask: UInt32) {
        
        line.position = CGPoint(x: x, y: y)
        line.zPosition = z
        line.size = CGSize(width: width, height: height)
        line.physicsBody = SKPhysicsBody (circleOfRadius: circleOfRadius)
        line.name = name
        line.physicsBody?.categoryBitMask = categoryBitMask
        line.physicsBody?.contactTestBitMask = contactTestBitMask
        line.physicsBody?.collisionBitMask = .zero
        line.physicsBody?.affectedByGravity = false
        
    }
    
    func createBG() {
        
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
    
    func pauseGame() {
        self.isPaused = true
        audioPlayerController.player?.pause()
    }
    
    func resumeGame() {
        self.isPaused = false
        audioPlayerController.player?.play()
    }
    
    func gameFinish(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "endstory")
        vc.view.frame = (self.view?.frame)!
        UIView.transition(with: self.view!, duration: 0.1, options: .curveEaseOut, animations:
            {
                self.view?.window?.rootViewController = vc
            }, completion: { completed in })
    }
    
}

extension GameScene : SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision : UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == notCategory | pagarCategory{
            
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

            // Start Audio Engine and Recording
            self.chordClassifierViewController.startAudioEngine()
            
        }
        
        if collision == chordLine1Category | pagarCategory {
            print("1ST CHORD LINE")
            
            if self.chordClassifierViewController.isCorrectChord == true {
                print("BENER DI 1")
                self.correctChord.isHidden = false
                self.feedbackLabel.isHidden = false
            }
        }else if collision == chordLine2Category | pagarCategory {
            print("2ND CHORD LINE")

            if self.chordClassifierViewController.isCorrectChord == true {
                print("BENER DI 2")
                self.correctChord.isHidden = false
                self.feedbackLabel.isHidden = false
            }
        } else if collision == chordLine3Category | pagarCategory {
            print("3RD CHORD LINE")

            if self.chordClassifierViewController.isCorrectChord == true {
                print("BENER DI 3")
                self.correctChord.isHidden = false
                self.feedbackLabel.isHidden = false
            }
        }
        
        if collision == endCategory | pagarCategory {
            print("Akhir")
            
            self.correctChord.isHidden = true
            self.feedbackLabel.isHidden = true
            self.chordClassifierViewController.stopAudioEngine()
            
            if self.chordClassifierViewController.isCorrectChord == true {
                
                score += 1
                scoreNode.text = "\(score) / 10"
                lastprogressNode.text = "\(score)/ 10"
                
                addProgress(progressLevel: 42 + newProgress)
                self.lastscore = 42 + newProgress
                lastprogressBar.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.lastscore, height: 35), cornerRadius: 50).cgPath
                print(self.lastscore)
                newProgress += 42
                
            } else {
                self.correctChord.isHidden = true
            }
        }
        
    }

        
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let nodeUserTapped = atPoint(pointOfTouch)
            
            if nodeUserTapped.name == "pauseBtn" {
                if flagpause == false {
                    if (self.isPaused == false) {
                        screenOverlay.isHidden = false
                        isinPause = true
                        flagpause = true
                        pauseGame()
                        pauseLayer.isHidden = false
                        }
                }
            }
            
            if nodeUserTapped.name == "resumeBtn" {
                counter = counterstartValue
                countdownLabel.text = "\(counter)"
                countdownLabel.isHidden = false
                pauseLayer.isHidden = true
                isNotBegin = true
            }
            
            if nodeUserTapped.name == "quitBtn" {
                confirmationquitLayer.isHidden = false
                flagconfirm = true
            }
            
            if nodeUserTapped.name == "cancelBtn" {
                confirmationquitLayer.isHidden = true
            }
            
            if nodeUserTapped.name == "restartBtn" {
                self.removeAllChildren()
                self.removeAllActions()
                self.scene?.removeFromParent()
                let gameScene = GameScene(size: self.size)
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene)
            }
            
            if nodeUserTapped.name == "quitBtn" {
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



