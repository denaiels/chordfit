//
//  ChooseBaseKeyPopupViewController.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 17/06/21.
//

import UIKit

class ChooseBaseKeyPopupViewController: UIViewController {
    
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var popupContentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var basekeySegmentedControl: UISegmentedControl!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    
    var baseKey: String = "C"
    var songToPlay: Song?
        
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            let endY = 0.5 + popupContentView.frame.size.width / popupContentView.frame.size.height / 2
            gradientLayer.endPoint = CGPoint(x: 1, y: endY)
        
        let chordFitColors = ChordFitColors()
        let color1 = chordFitColors.lightPurple?.cgColor
        let color2 = chordFitColors.purple?.cgColor
        
        gradientLayer.colors = [color1, color2]
        gradientLayer.cornerRadius = 50
        
        gradientLayer.frame = popupContentView.bounds
        popupContentView.layer.insertSublayer(gradientLayer, at: 0)
        popupContentView.layer.cornerRadius = 50
//        popupContentView.roundCorners(corners: [.topLeft, .topRight], radius: 50)
        
        
//        let colorSelected = [NSAttributedString.Key.foregroundColor: UI]
//        basekeySegmentedControl.layer.borderWidth = 0.4
//        basekeySegmentedControl.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        basekeySegmentedControl.setTitleTextAttributes(colorSelected, for: .normal)

        
//
//        popupContentView.isUserInteractionEnabled = false

        outerView.layer.cornerRadius = 50
        popupContentView.layer.borderWidth = 3
        popupContentView.layer.borderColor = ChordFitColors.init().white?.cgColor
        
        playButton.layer.cornerRadius = 25
        playButton.layer.borderWidth = 2
        playButton.layer.borderColor = ChordFitColors.init().white?.cgColor
        playButton.isUserInteractionEnabled = true
        
        
        
        titleLabel.text = songToPlay?.title
        artistLabel.text = songToPlay?.artist
        genreLabel.text = songToPlay?.genre
        bpmLabel.text = "\(songToPlay?.beat ?? 122) bpm"
    }
    
    
    
  
    @IBAction func playSong(_ sender: UIButton) {
        //perform segue ke halaman adit
        performSegue(withIdentifier: "chooseBaseKeyPopupToGamePlaySegue", sender: self)
        print("hehe")
    }
    
        
    @IBAction func dismiss(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToSongSelection", sender: self)
    }
    
    @IBAction func baseKeyDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            baseKey = "C"
            print(baseKey)
        case 1:
            baseKey = "F"
            print(baseKey)
        case 2:
            baseKey = "G"
            print(baseKey)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //prepare ke adit
        if segue.identifier == "chooseBaseKeyPopupToGamePlaySegue" {
            if let viewController = segue.destination as? GameSceneViewController {
                viewController.songToPlay = songToPlay
                viewController.baseKey = baseKey
                print(viewController.songToPlay)
            }
        }
    }
    


}
