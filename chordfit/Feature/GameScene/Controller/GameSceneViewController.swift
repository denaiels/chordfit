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
    func quitBtnTapped(text: String)
    func returnData(text: String)
}

protocol GSViewControllerDelegate {
    func dismissChooseBaseKey()
}

class GameSceneViewController: UIViewController {
    
    var baseKey: String = "C"
    var songToPlay: Song?
    var gsDelegate: GSViewControllerDelegate?
    var songSelectionDelegate: GameSceneDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene"){
                // Set the scale mode to scale to fit the window
                if let gameScene = scene as? GameScene{
                    gameScene.setText(text: baseKey)
                    gameScene.setDelegate(delegate: self)
                    gameScene.setSongSelectionDelegate(delegate: songSelectionDelegate)
                    
                    scene.scaleMode = .aspectFill
                   
                        // Present the scene
                    view.presentScene(scene)
                    
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            
        }
        }
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            let scene = GameScene(size: view.bounds.size)
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
//        let scene : GameScene = GameScene(size: skview.frame.size)
//        skview.presentScene(scene)
    }
}

extension GameSceneViewController : GameSceneDelegate{
    func returnData(text: String) {
        
    }
    
    func quitBtnTapped(text: String) {
        print(text)
//        performSegue(withIdentifier: "goToSongSelection", sender: self)
        print("\(gsDelegate), INI DARI GAMESCENE" )
        gsDelegate?.dismissChooseBaseKey()
        self.dismiss(animated: true, completion: nil)
    }
}

