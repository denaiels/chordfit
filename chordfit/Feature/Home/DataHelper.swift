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
		let songs = [
            (title: "Demons", artist: "Imagine Dragons", bpm: 90, category: "Normal", imageName: "tralala" , playedC: false, playedF: false, playedG: false, progression: "I - V- vi - IV", poin: 0 ),
            (title: "I'm Yours", artist: "Jason Mraz", bpm: 74, category: "Normal", imageName: "tralala" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - IV", poin: 0 ),
            (title: "Beautiful in White", artist: "Westlife", bpm: 76, category: "Hard", imageName: "tralala" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - iii - IV -I - IV -V", poin: 0 ),
            (title: "Memories", artist: "Maroon 5", bpm: 90, category: "Hard", imageName: "tralala" , playedC: false, playedF: false, playedG: false, progression: "I - V - vi - iii - IV -I - IV -V", poin: 0 )
        ]
		
		for song in songs {
			let newSongs = NSEntityDescription.insertNewObject(forEntityName: "Songs", into: context) as! Songs
			newSongs.title = song.title
            newSongs.artist = song.artist
            newSongs.bpm = Int64(song.bpm)
            newSongs.category = song.category
            newSongs.imageName = song.imageName
            newSongs.playedC = song.playedC
            newSongs.playedG = song.playedG
            newSongs.playedF = song.playedF
            newSongs.progression = song.progression
            newSongs.poin = Int64(song.poin)
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
