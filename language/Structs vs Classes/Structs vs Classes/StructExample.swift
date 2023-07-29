//
//  StructExample.swift
//  Structs vs Classes
//
//  Created by Kyuhong Jo on 2023/07/29.
//

import Foundation

struct StructHero {
    var name: String
    var universe: String
    
    mutating func reverseName() -> String {
        self.name = String(self.name.reversed())
        return self.name
    }
}


