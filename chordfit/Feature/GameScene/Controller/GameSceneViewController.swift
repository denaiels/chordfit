//
//  GameViewController.swift
//  newConveyor
//
//  Created by Aditya Ramadhan on 10/06/21.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameSceneDelegate {
    func dismissChooseBaseKeyPopup(text: String)
    func returnData(text: String)
    func sendGameResultToSongSelection(songTitle: String, key: String, userGetStar: Bool)
}

protocol GSViewControllerDelegate {
    func dismissChooseBaseKey()
}

class GameSceneViewController: UIViewController {
    
    // Delegate
    var gsDelegate: GSViewControllerDelegate?
    var songSelectionDelegate: GameSceneDelegate?
    
    // Song Detail
    var songs = SongRepository.shared.getSongs()
    
    var songTitle: String?
    var songToPlay: Song?
    var baseKey: String?
    
    // Aftermath
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene"){
                
                // Set the scale mode to scale to fit the window
                if let gameScene = scene as? GameScene{
                    
                    // Set Base Key in GameScene SKScene
                    gameScene.setSongDetail(song: songToPlay!, key: baseKey ?? "C")
                    
                    // Set Delegate to send back progress to SongSelection page
                    gameScene.setDelegate(delegate: self)
                    gameScene.setSongSelectionDelegate(delegate: songSelectionDelegate)
                    
                    scene.scaleMode = .aspectFill
                    view.presentScene(scene)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    func setSongAndBaseKey(titleOfSong: String, key: String) {
        songTitle = titleOfSong
        
        for song in songs {
            if song.title == songTitle {
                songToPlay = song
            }
        }
        
        baseKey = key
    }
}

extension GameSceneViewController : GameSceneDelegate{
    func sendGameResultToSongSelection(songTitle: String, key: String, userGetStar: Bool) {
        
    }
    
    func returnData(text: String) {
        
    }
    
    func dismissChooseBaseKeyPopup(text: String) {
        print("\(gsDelegate), INI DARI GAMESCENE")
        
        // Dismiss Choose Base Key Popup
        gsDelegate?.dismissChooseBaseKey()
        
        //
        self.dismiss(animated: true, completion: nil)
    }
}

