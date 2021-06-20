//
//  SongSelection_TutorialViewController+SongSelectionTableViewCellDelegate.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 12/06/21.
//

import UIKit

extension SongSelection_TutorialViewController: SongSelectionTableViewCellDelegate {
    func songDidTap(song: Song) {
        print(song.title)
    }

}
