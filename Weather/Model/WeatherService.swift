//
//  WeatherService.swift
//  Weather
//
//  Created by Edwin Guerrero on 10/2/20.
//

import Foundation

class WeatherService
{
    let weatherAPIKey: String
    let currentWeatherBaseURL: URL?
    
    init(APIKey: String) {
        self.weatherAPIKey = APIKey
        self.currentWeatherBaseURL = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(APIKey)")
    }
    
    func getCurrentWeather(cityOrTown: String)
    {
        if let url = URL(string: "\(self.currentWeatherBaseURL!)&q=\(cityOrTown)")
        {
            let networkProcessor = NetworkProcessor(url: url)
            networkProcessor.downloadJSONFromURL {(jsonDictionary) in
                print(jsonDictionary!) // prints dictionary, not the size
            }
        }
    }
        
}
