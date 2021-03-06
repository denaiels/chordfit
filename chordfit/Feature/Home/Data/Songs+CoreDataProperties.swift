//
//  Songs+CoreDataProperties.swift
//  chordfit
//
//  Created by Daniel Santoso on 21/06/21.
//
//

import Foundation
import CoreData


extension Songs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Songs> {
        return NSFetchRequest<Songs>(entityName: "Songs")
    }

    @NSManaged public var artist: String?
    @NSManaged public var bpm: Int64
    @NSManaged public var category: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageName: String?
    @NSManaged public var playedC: Bool
    @NSManaged public var playedF: Bool
    @NSManaged public var playedG: Bool
    @NSManaged public var poin: Int64
    @NSManaged public var progression: String?
    @NSManaged public var title: String?
    @NSManaged public var chords: NSObject?

}

extension Songs : Identifiable {

}
