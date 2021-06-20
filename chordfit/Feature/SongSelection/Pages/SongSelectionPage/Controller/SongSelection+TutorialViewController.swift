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
    var song: Song?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songSelection_TutorialView.songSelectionTableView.dataSource = self
        songSelection_TutorialView.songSelectionTableView.delegate = self
        
        songSelection_TutorialView.songSelectionTableView.registerCell(type: SongSelectionTableViewCell.self, identifier: "songSelectionCell")
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
