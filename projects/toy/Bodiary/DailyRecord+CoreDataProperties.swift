//
//  DailyRecord+CoreDataProperties.swift
//  Bodiary
//
//  Created by Kyuhong Jo on 5/10/24.
//
//

import Foundation
import CoreData


extension DailyRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyRecord> {
        return NSFetchRequest<DailyRecord>(entityName: "DailyRecord")
    }

    @NSManaged public var message: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var image: Data?

}

extension DailyRecord : Identifiable {

}
