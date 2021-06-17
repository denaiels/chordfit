//
//  SongSelection+TutorialViewController.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 12/06/21.
//

import UIKit

class SongSelection_TutorialViewController: UIViewController {

    @IBOutlet weak var songSelection_TutorialView: SongSelection_TutorialView!
    @IBOutlet weak var overlayView: UIView!
    
    var songs: [Song]?
    var song: Song?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.isHidden = true
        songs = SongRepository.shared.getSongs()
        
        songSelection_TutorialView.songSelectionTableView.dataSource = self
        songSelection_TutorialView.songSelectionTableView.delegate = self
        
        songSelection_TutorialView.songSelectionTableView.registerCell(type: SongSelectionTableViewCell.self, identifier: "songSelectionCell")
       
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
}
