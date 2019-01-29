//
//  Storage.swift
//  Weather
//
//  Created by Cat on 1/21/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import Foundation

class Storage {
    
    static var shared = Storage()
    
    var citiesListArray:    [String] = []
    var countriesListArray: [String] = []
    
    var citiesList: [String:String] = [:]
    
    var dataList: [String] = []
    
    private init() {}
    
}
