//
//  LinkService.swift
//  Weather
//
//  Created by Cat on 1/24/19.
//  Copyright © 2019 Cat. All rights reserved.
//

import UIKit

class LinkService {
    
    class func createURL(city: String) {
        let fullLink = Link.firstPartOfTheLink + city + Link.secondPartOfTheLink
        url = fullLink
    }
    
}
