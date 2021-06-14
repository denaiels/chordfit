//
//  SongStaticDataStore.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 11/06/21.
//

import Foundation

struct SongStaticDataStore {
    let songProgression: [SongProgression] = [
        .I_V_vi_iii_IV_I_IV_V, .vi_I_V_IV
    ]
    
    func createSong() -> [Song] {
        var arrSongs = [Song]()
        
        let countingStars = Song(title: "Counting Stars", genre: "Pop", artist: "OneRepublic", image: "Counting Stars", beat: 122, chords: ["cobain"])
        let radioactive = Song(title: "Radioactive", genre: "Alternative Rock", artist: "Imagine Dragons", image: "Radioactive", beat: 68, chords: ["cobain"])
        let beautifulInWhite = Song(title: "Beautiful in White", genre: "Pop", artist: "Shane Filan", image: "Beautiful in White", beat: 78, chords: ["cobain"])
        let memories = Song(title: "Memories", genre: "Pop", artist: "Maroon 5", image: "Memories", beat: 91, chords: ["cobain"])
        
        arrSongs.append(countingStars)
        arrSongs.append(radioactive)
        arrSongs.append(beautifulInWhite)
        arrSongs.append(memories)
        
        return arrSongs
    }
}
