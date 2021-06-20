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
    
    var baseKey: String = "C"
    var songToPlay: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene"){
                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
           
                // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
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
