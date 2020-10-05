//
//  CurrentWeather.swift
//  Weather
//
//  Created by Edwin Guerrero on 10/4/20.
//

import Foundation

class CurrentWeather
{
    let temp_c: Int?
    let temp_f: Int?
    let humidity: Int?
    let precipInches: Int?
    
    init(weatherDictionary: [String : Any])
    {
        if let temp_c_Double = weatherDictionary["temp_c"] as? Double
        {
            temp_c = Int(temp_c_Double)
        } else {
            temp_c = nil
        }
        
        if let temp_f_Double = weatherDictionary["temp_f"] as? Double
        {
            temp_f = Int(temp_f_Double)
        } else {
            temp_f = nil
        }
        
        humidity = weatherDictionary["humidity"] as? Int
        
        if let precipInchesDouble = weatherDictionary["precip_in"] as? Double
        {
            precipInches = Int(precipInchesDouble)
        } else {
            precipInches = nil
        }
    }
    
}
