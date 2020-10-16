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
    var networkProcessor: NetworkProcessor?
    
    init() {
        self.weatherAPIKey = "47096294b48b43ee896155647203009"
        self.currentWeatherBaseURL = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(self.weatherAPIKey)")
    }
    
    func setupNetworkProcessor(request networkRequest: String)
    {
        var request = networkRequest.trimmingCharacters(in: .whitespacesAndNewlines)
        request = networkRequest.replacingOccurrences(of: " ", with: "%20")
        // Optionals are not allowed in URLs. Must force unwrap.
        if let url = URL(string: "\(self.currentWeatherBaseURL!)&q=\(request)")
        {
            self.networkProcessor = NetworkProcessor(url: url)
        }
    }
    
    func getLocation(_ location: String, completion: @escaping (Location?) -> Void)
    {
        setupNetworkProcessor(request: location)
        networkProcessor!.downloadJSONFromURL({  (jsonDictionary) in
            if let weatherLocationDictionary = jsonDictionary?["location"] as? [String : Any]
            {
                // parse JSON into model object
                let location = Location(dictionary: weatherLocationDictionary)
                completion(location)
            } else {
                completion(nil)
            }
        })
    }
    
    func getCurrentWeather(_ location: String, completion: @escaping (CurrentWeather?) -> Void)
    {
        setupNetworkProcessor(request: location)
        networkProcessor!.downloadJSONFromURL({  (jsonDictionary) in
            if let currentWeatherDictionary = jsonDictionary?["current"] as? [String : Any]
            {
                // parse JSON into model object
                // print(currentWeatherDictionary)
                let currentWeather = CurrentWeather(dictionary: currentWeatherDictionary)
                completion(currentWeather)
            } else {
                completion(nil)
            }
        })
    }
    
    func getCondition(_ location: String, completion: @escaping (Condition?) -> Void)
    {
        setupNetworkProcessor(request: location)
        networkProcessor!.downloadJSONFromURL({  (jsonDictionary) in
            if let currentDictionary = jsonDictionary?["current"] as? [String : Any]
            {
                // parse JSON into model object
                if let conditionDictionary = currentDictionary["condition"] as? [String : Any]
                {
                    let condition = Condition(dictionary: conditionDictionary)
                    completion(condition)
                }
                
            } else {
                completion(nil)
            }
        })
    }
    
}
