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
    
    init(APIKey: String) {
        self.weatherAPIKey = APIKey
        self.currentWeatherBaseURL = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(APIKey)")
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
                let location = Location(locationDictionary: weatherLocationDictionary)
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
                let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                completion(currentWeather)
            } else {
                completion(nil)
            }
        })
    }
}
