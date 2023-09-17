//
//  MemoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Kyuhong Jo on 2023/09/17.
//
//

import Foundation
import CoreData


extension MemoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoData> {
        return NSFetchRequest<MemoData>(entityName: "MemoData")
    }

    @NSManaged public var memo: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int16

}

extension MemoData : Identifiable {

}
