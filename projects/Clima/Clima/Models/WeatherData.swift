//
//  WeatherData.swift
//  Clima
//
//  Created by Kyuhong Jo on 2023/06/26.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
    
}

struct Weather: Decodable {
    let description: String
}
