//
//  Request.swift
//  Weather
//
//  Created by Cat on 1/21/19.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit

class Request {
    
    class func sendRequest(link: String, completion: @escaping (Data?) -> Void) {
        guard let urlString = URL(string: link) else
        { return }
        
        URLSession.shared.dataTask(with: urlString) { (data, response, error)  in
            
            if error == nil {
                completion(data)
            } else {
                completion(nil)
            }
            
            }.resume()
    }
    
}
