//
//  Location.swift
//  Weather
//
//  Created by Edwin Guerrero on 10/7/20.
//

import Foundation

class Location
{
    let cityTown: String?
    let state: String?
    
    init(dictionary: [String : Any])
    {
        if let cityTown = dictionary["name"] as? String
        {
            self.cityTown = cityTown
        } else {
            self.cityTown = nil
        }
        
        if let state = dictionary["region"] as? String
        {
            self.state = state
        } else {
            self.state = nil
        }
    }
}
