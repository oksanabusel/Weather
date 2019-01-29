//
//  WeatherDataModel.swift
//  Weather
//
//  Created by Cat on 19/1/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

struct WeatherData: Codable {
    var main: Main
    var sys: Sys
    var name: String
    var wind: Wind
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Float
    var pressure: Float
    var humidity: Float
    var tempMin: Float
    var tempMax: Float
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Codable {
    var speed: Double
}

struct Sys: Codable {
    var sunrise: Int
    var sunset: Int
}

struct Weather: Codable {
    var main: String
    var description: String
}
