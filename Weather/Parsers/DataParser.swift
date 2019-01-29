//
//  Parser.swift
//  Weather
//
//  Created by Cat on 1/21/19.
//  Copyright © 2019 Cat. All rights reserved.
//

import UIKit

class Parser {
    
    class func parse(receivedData: Data) -> WeatherData? {
        let jsonDecoder = JSONDecoder()
        
        do {
            let weatherData = try jsonDecoder.decode(WeatherData.self, from: receivedData)
            return weatherData
        } catch {
            print(error)
        }
        return nil
    }

}
