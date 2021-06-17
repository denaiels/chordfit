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
    
    var baseKey: String = "C"
    var songToPlay: Song?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            let endY = 0.5 + popupContentView.frame.size.width / popupContentView.frame.size.height / 2
            gradientLayer.endPoint = CGPoint(x: 1, y: endY)
        gradientLayer.colors = [
            ChordFitColors.init().lightPurple?.cgColor,
            ChordFitColors.init().purple?.cgColor
        ]
        gradientLayer.cornerRadius = 36
        
        gradientLayer.frame = popupContentView.bounds
        popupContentView.layer.insertSublayer(gradientLayer, at: 0)
//        popupContentView.isUserInteractionEnabled = false

        outerView.layer.cornerRadius = 50
        outerView.layer.borderWidth = 3
        outerView.layer.borderColor = ChordFitColors.init().white?.cgColor
        
        playButton.layer.cornerRadius = 25
        playButton.layer.borderWidth = 2
        playButton.layer.borderColor = ChordFitColors.init().white?.cgColor
        playButton.isUserInteractionEnabled = true
        
        popupContentView.layer.cornerRadius = 50
        
        titleLabel.text = songToPlay?.title
        artistLabel.text = songToPlay?.artist
        genreLabel.text = songToPlay?.genre
        bpmLabel.text = "\(songToPlay?.beat ?? 122) bpm"
    }
    
    
    
  
    @IBAction func playSong(_ sender: UIButton) {
        //perform segue ke halaman adit
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
//        if segue.identifier == "chooseBasekeyPopupSegue" {
//            if let viewController = segue.destination as? ChooseBaseKeyPopupViewController {
////                viewController.songToPlay = song
////                print(song?.title)
//            }
//        }
    }
    


}
