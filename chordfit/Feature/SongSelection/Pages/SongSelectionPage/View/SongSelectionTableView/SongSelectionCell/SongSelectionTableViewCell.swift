//
//  SongSelectionTableViewCell.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 11/06/21.
//

import UIKit

class SongSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var beatLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var CStar: UIImageView!
    @IBOutlet weak var FStar: UIImageView!
    @IBOutlet weak var GStar: UIImageView!
    var beat: String!
    
    
    var delegate: SongSelectionTableViewCellDelegate!
    var song: Song? {
        didSet {
            setupView()
        }
    }
    
    private func setupView() {
        titleLabel.text = song?.title
        artistLabel.text = song?.artist
        beatLabel.text = "\(song?.beat) bpm"
        genreLabel.text = song?.genre
    }
    
}
