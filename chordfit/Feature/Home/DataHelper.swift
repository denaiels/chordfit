import Foundation
import CoreData

public class DataHelper {
	let context: NSManagedObjectContext
	
	init(context: NSManagedObjectContext) {
		self.context = context
	}
	
	public func seedDataStore() {
		seedSongs()
	}
	
	fileprivate func seedSongs() {
        
        let imYoursChords = [["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4]]
        
        let demonsChords = [["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4]]
        
        let beautifulInWhiteChords = [["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 2], ["V", 2], ["IV", 2], ["I", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["IV", 2], ["I", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 2], ["V", 2], ["IV", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["vi", 4], ["IV", 4], ["I", 4], ["V", 4], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["V", 4], ["I", 4]]
        
        let memoriesChord = [["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2], ["V", 2], ["vi", 2], ["iii", 2], ["IV", 2], ["I", 2], ["IV", 2], ["V", 2], ["I", 2], ["V", 2], ["I", 2]]
        
		let songsNormal = [
            (title: "Demons", artist: "Imagine Dragons", bpm: 90, category: "Normal", imageName: "Demons" , playedC: false, playedF: false, playedG: false, progression: "I - V- vi - IV", poin: 0, genre: "Alternative Rock", chords: demonsChords),
            (title: "I'm Yours", artist: "Jason Mraz", bpm: 74, category: "Normal", imageName: "Im Yours" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - IV", poin: 0, genre: "Pop", chords: imYoursChords)
        ]
        
        let songsHard = [
            (title: "Beautiful in White", artist: "Westlife", bpm: 76, category: "Hard", imageName: "Beautiful in White" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - iii - IV -I - IV -V", poin: 0, genre: "Pop", chords: beautifulInWhiteChords),
            (title: "Memories", artist: "Maroon 5", bpm: 90, category: "Hard", imageName: "Memories" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - iii - IV -I - IV -V", poin: 0, genre: "Pop", chords: memoriesChord)
        ]
		
		for song in songsNormal {
			let newSongsNormal = NSEntityDescription.insertNewObject(forEntityName: "Songs", into: context) as! Songs
			newSongsNormal.title = song.title
            newSongsNormal.artist = song.artist
            newSongsNormal.bpm = Int64(song.bpm)
            newSongsNormal.category = song.category
            newSongsNormal.imageName = song.imageName
            newSongsNormal.playedC = song.playedC
            newSongsNormal.playedG = song.playedG
            newSongsNormal.playedF = song.playedF
            newSongsNormal.progression = song.progression
            newSongsNormal.poin = Int64(song.poin)
            newSongsNormal.genre = song.genre
		}
        
        for song in songsHard {
            let newSongsHard = NSEntityDescription.insertNewObject(forEntityName: "Songs", into: context) as! Songs
            newSongsHard.title = song.title
            newSongsHard.artist = song.artist
            newSongsHard.bpm = Int64(song.bpm)
            newSongsHard.category = song.category
            newSongsHard.imageName = song.imageName
            newSongsHard.playedC = song.playedC
            newSongsHard.playedG = song.playedG
            newSongsHard.playedF = song.playedF
            newSongsHard.progression = song.progression
            newSongsHard.poin = Int64(song.poin)
            newSongsHard.genre = song.genre
        }
		
		do {
            
			try context.save()
		} catch _ {
		
        }
	}
	
	public func printAllSongs() {
		let songFetchRequest = NSFetchRequest<Songs>(entityName: "Songs")
		let primarySortDescriptor = NSSortDescriptor(key: "category", ascending: true)
		
		songFetchRequest.sortDescriptors = [primarySortDescriptor]
		
		let allSongs = try! context.fetch(songFetchRequest)
		
		for song in allSongs {
			print("Song Name: \(song.title)\nLocation: \(song.artist)\nterminator: \(song.bpm)\nterminator: \(song.category)")
		}
	}
	
}
