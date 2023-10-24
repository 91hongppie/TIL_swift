//
//  Category.swift
//  Todoey
//
//  Created by Kyuhong Jo on 2023/07/20.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundColor: String = ""
    let item = List<Item>()
}
