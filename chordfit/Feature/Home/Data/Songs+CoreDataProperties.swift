//
//  Songs+CoreDataProperties.swift
//  chordfit
//
//  Created by Graciela gabrielle Angeline on 17/06/21.
//
//

import Foundation
import CoreData


extension Songs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Songs> {
        return NSFetchRequest<Songs>(entityName: "Songs")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var poin: Int64
    @NSManaged public var artist: String
    @NSManaged public var title: String
    @NSManaged public var bpm: Int64
    @NSManaged public var imageName: String
    @NSManaged public var playedC: Bool
    @NSManaged public var playedF: Bool
    @NSManaged public var playedG: Bool
    @NSManaged public var category: String
    @NSManaged public var progression: String

}

extension Songs : Identifiable {

}
