//
//  AudioPlayerController.swift
//  chordfit
//
//  Created by Daniel Santoso on 20/06/21.
//

import AVFoundation

class AudioPlayerController {
    
    var player: AVAudioPlayer?
    
    
    func playAudio(filename: String) {
        if let player = player, player.isPlaying {
            
        } else {
            let urlString = Bundle.main.path(forResource: filename, ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                
                player.play()
                
            } catch {
                print("Audio can't be played, something went wrong")
            }
        }
    }
    
    func getAudioDuration(filename: String) -> Float64 {
        guard let urlString = Bundle.main.path(forResource: filename, ofType: "mp3") else { return 0 }
        
//        let asset = AVURLAsset(URL: NSURL(fileURLWithPath: urlString), options: nil)
        let asset = AVURLAsset(url: URL(fileURLWithPath: urlString), options: nil)
        let audioDuration = asset.duration
        let audioDurationSeconds = CMTimeGetSeconds(audioDuration)
        
        print("AUDIO DURATION: \(audioDurationSeconds)")
        
        return audioDurationSeconds
    }
    
}
