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
        
        let imYours = Song(title: "I'm Yours", genre: "Pop", artist: "Jason Mraz", image: "Im Yours", beat: 151, chords: [["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4]])
        let demons = Song(title: "Demons", genre: "Alternative Rock", artist: "Imagine Dragons", image: "Demons", beat: 88, chords: [["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4]])
        let beautifulInWhite = Song(title: "Beautiful in White", genre: "Pop", artist: "Shane Filan", image: "Beautiful in White", beat: 78, chords: [["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 2], ["V", 2], ["IV", 2], ["I", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["IV", 2], ["I", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 2], ["V", 2], ["IV", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 4]])
        let memories = Song(title: "Memories", genre: "Pop", artist: "Maroon 5", image: "Memories", beat: 91, chords: [["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2]])
        
        arrSongs.append(imYours)
        arrSongs.append(demons)
        arrSongs.append(beautifulInWhite)
        arrSongs.append(memories)
        
        return arrSongs
    }
}
