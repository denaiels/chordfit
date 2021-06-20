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
		let songsNormal = [
            (title: "Demons", artist: "Imagine Dragons", bpm: 90, category: "Normal", imageName: "tralala" , playedC: false, playedF: false, playedG: false, progression: "I - V- vi - IV", poin: 0 ),
            (title: "I'm Yours", artist: "Jason Mraz", bpm: 74, category: "Normal", imageName: "tralala" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - IV", poin: 0 )
        ]
        
        let songsHard = [
            (title: "Beautiful in White", artist: "Westlife", bpm: 76, category: "Hard", imageName: "tralala" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - iii - IV -I - IV -V", poin: 0 ),
            (title: "Memories", artist: "Maroon 5", bpm: 90, category: "Hard", imageName: "tralala" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - iii - IV -I - IV -V", poin: 0 )
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
