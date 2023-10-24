//
//  MusicSaved+CoreDataProperties.swift
//  MusicApp
//
//  Created by Kyuhong Jo on 2023/09/24.
//
//

import Foundation
import CoreData


extension MusicSaved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicSaved> {
        return NSFetchRequest<MusicSaved>(entityName: "MusicSaved")
    }

    @NSManaged public var albumName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var myMessage: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var savedDate: Date?
    @NSManaged public var somgName: String?

}

extension MusicSaved : Identifiable {

}
