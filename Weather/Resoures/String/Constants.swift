//
//  Constants.swift
//  Weather
//
//  Created by Cat on 1/21/19.
//  Copyright © 2019 Cat. All rights reserved.
//

import Foundation

struct StringModificators {
    static let сelsiusSign: String     = "°"
    static let maxTemp: String         = "Max: "
    static let minTemp: String         = "Min: "
    static let space: String           = "   "
    static let persents: String        = "%"
    static let metersPerSecond: String = " m/s"
}

struct WeatherParameters {
    static let snow: String            = "Snow"
    static let fewClouds: String       = "Few Clouds"
    static let scatteredClouds: String = "Scattered Clouds"
    static let clouds: String          = "Clouds"
    static let showerRain: String      = "Shower Rain"
    static let rain: String            = "Rain"
    static let thunderstorm: String    = "Thunderstorm"
    static let clear: String           = "Clear"
    static let mist: String            = "Mist"
}

struct AlertMessages {
    static let requestFail: String     = "Request failure."
    static let errorTitle: String      = "Error"
    static let okTitle: String         = "Ok"
}

struct Link {
    static let firstPartOfTheLink: String  = "https://api.openweathermap.org/data/2.5/weather?q="
    static let secondPartOfTheLink: String = "&appid=c2089ead6183c23d2e37c1ff13831fbe&units=metric"
}

let toMainScreenSegue: String = "toMainScreenSegue"
var url: String               = ""
