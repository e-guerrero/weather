//
//  ViewController.swift
//  Weather
//
//  Created by Edwin Guerrero on 9/29/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var temp_f_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherService = WeatherService(APIKey: "47096294b48b43ee896155647203009")
        weatherService.getCurrentWeather(cityOrTown: "Norcross") { (currentWeather) in
            
            // This is off the Main Queue
            print(currentWeather!)
            print("temp c: \(currentWeather!.temp_c!)")
            print("temp f: \(currentWeather!.temp_f!)")
            print("humidity: \(currentWeather!.humidity!)")
            print("precipitation (inch): \(currentWeather!.precipInches!)")
            
            if let currentWeather = currentWeather {
                // RULE: All UI code must happen on the main queue!
                // TODO: Get back to the main queue using Grand Central Dispatch (GCD)
                DispatchQueue.main.async {
                    // This will execute on the main thread.
                    if let temp_f = currentWeather.temp_f {
                        self.temp_f_Label.text = "\(temp_f)° F"
                    } else {
                        self.temp_f_Label.text = "-"
                    }
                }
            }
        }
    }
}

