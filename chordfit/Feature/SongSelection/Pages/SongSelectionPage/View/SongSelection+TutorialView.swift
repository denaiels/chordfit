//
//  SongSelectionView.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 12/06/21.
//

import UIKit

class SongSelection_TutorialView: UIView {
    
//    ini nanti tempat buat gabungin song selection + tutorial untuk ngatur custom viewnya
    
    @IBOutlet weak var songSelectionTableView: UITableView!
    
    
    var songs: [Song]? {
        didSet {
            print(songs)
            setup()
        }
    }
    
    func setup() {
        songSelectionTableView.registerCell(type: SongSelectionTableViewCell.self, identifier: "songSelectionCell")
    }

}
