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

extension SongSelection_TutorialViewController: GameSceneDelegate{
    func sendGameResultToSongSelection(songTitle: String, key: String, userGetStar: Bool) {
        getStar = userGetStar
        baseKeyFromGameplay = key
        
        print("BOLEH DAPAT BINTANG: \(getStar)")
        print("BaseKey: \(key)")
    }
    
    func dismissChooseBaseKeyPopup(text: String) {
        
    }
    
    func returnData(text: String){
        print(text)
    }
}
