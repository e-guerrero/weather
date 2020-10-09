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
    
    init(locationDictionary: [String : Any])
    {
        if let cityTown = locationDictionary["name"] as? String
        {
            self.cityTown = cityTown
        } else {
            self.cityTown = nil
        }
        
        if let state = locationDictionary["region"] as? String
        {
            self.state = state
        } else {
            self.state = nil
        }
    }
}
