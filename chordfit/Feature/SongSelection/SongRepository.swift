//
//  SongRepository.swift
//  chordfit
//
//  Created by Yafonia Hutabarat on 11/06/21.
//

import UIKit

class SongRepository {
    
    var staticDataStore: SongStaticDataStore
    
    var songProgression: [SongProgression]?
    var songs: [Song]?
    
    func getSongs() -> [Song] {
        if songs == nil {
            self.songProgression = staticDataStore.songProgression
            self.songs = staticDataStore.createSong()
        }
        return songs ?? []
    }
    
    static let shared = SongRepository(staticDataStore: SongStaticDataStore())
    
    private init(staticDataStore: SongStaticDataStore) {
        self.staticDataStore = staticDataStore
    }
}
