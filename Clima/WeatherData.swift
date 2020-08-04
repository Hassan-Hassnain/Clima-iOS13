//
//  WeatherData.swift
//  Clima
//
//  Created by Usama Sadiq on 11/14/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let visibility: Int
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}



