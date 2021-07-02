//
//  Song.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 11/06/21.
//

import Foundation
import UIKit

enum SongProgression: String, CaseIterable {
    case vi_I_V_IV = "vi_I_V_IV"
    case I_V_vi_iii_IV_I_IV_V = "I-V-vi-iii-IV-I-IV-V"
}

class Song {
    var title: String?
    var genre: String?
    var artist: String?
    var image: String?
    var beat: Int?
    var chords: [[Any]]
    var bpm: Int?
    
    init(title: String?, genre: String?, artist: String?, image: String?, beat: Int?, chords: [[Any]], bpm: Int?) {
        self.title = title
        self.genre = genre
        self.artist = artist
        self.image = image
        self.beat = beat
        self.chords = chords
        self.bpm = bpm
    }
}
