//
//  GameViewController.swift
//  newConveyor
//
//  Created by Aditya Ramadhan on 10/06/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameSceneViewController: UIViewController {

    var songToPlay: Song?
    var baseKey: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = self.view as! SKView?

        let scene = GameScene()
//        let scene = SKScene(fileNamed: "GameScene")
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view?.presentScene(scene)

        view?.ignoresSiblingOrder = true
        view?.showsFPS = true
        view?.showsNodeCount = true
        
//        if let view = self.view as! SKView? {
//
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene"){
//
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//
//
//                // Present the scene
//                view.presentScene(scene)
//
//                view.ignoresSiblingOrder = true
//                view.showsFPS = true
//                view.showsNodeCount = true
//            }
//        }
        
    }
}
