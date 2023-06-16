//
//  DemoURL.swift
//  Cassini
//
//  Created by Kyuhong Jo on 2023/05/16.
//

import Foundation

struct DemoURL
{
    static let Stanford = "https://images.pexels.com/photos/516541/pexels-photo-516541.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    
    static let NASA = [
        "Cassini": "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
        "Earth": "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
        "Saturn": "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
    ]
    
    static func NASAImageNamed(_ imageName: String?) -> NSURL? {
        if let urlstring = NASA[imageName ?? ""] {
            return NSURL(string: urlstring)
        } else {
            return nil
        }
    }
}
