//
//  JsonParser.swift
//  Weather
//
//  Created by Cat on 1/21/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class JsonParser {
  
  struct Location : Decodable {
    var name:    String
    var country: String
  }
  
  class func loadJson(_ fileName: String) -> [Location]? {
    let decoder = JSONDecoder()
    
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let jsonData = try decoder.decode([Location].self, from: data)
        return jsonData
      } catch {
        print("error:\(error)")
      }
    }
    return nil
  }
  
    class func getCitiesList() {
        let dataListArray = self.loadJson("Cities")
        
        for item in dataListArray! {
            if let city = item.name as? String {
                if let country = item.country as? String {
                    let cityCountryString = city + ", " + country
                    Storage.shared.dataList.append(cityCountryString)
                }
            }
        }
    }
    
}
