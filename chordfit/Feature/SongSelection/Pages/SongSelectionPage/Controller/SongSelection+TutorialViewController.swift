//
//  SongSelection+TutorialViewController.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 12/06/21.
//

import UIKit

class SongSelection_TutorialViewController: UIViewController {

    @IBOutlet weak var songSelection_TutorialView: SongSelection_TutorialView!
    
    var songs: [Song]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songSelection_TutorialView.songSelectionTableView.dataSource = self
        songSelection_TutorialView.songSelectionTableView.delegate = self
        
        songSelection_TutorialView.songSelectionTableView.registerCell(type: SongSelectionTableViewCell.self, identifier: "songSelectionCell")
       
    }


}
