//
//  ViewController.swift
//  Weather
//
//  Created by Edwin Guerrero on 9/29/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var temp_f_Label: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        displayLocation(textField)
        displayTemp(textField)
        displayCondition(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func displayLocation(_ textField: UITextField) -> Void
    {
        weatherService.getLocation("\(textField.text!)") { (location) in
            // Using "if let location = location" instead of "if location != nil" will allow you to no longer need to unwrap location.
            if let location = location
            {
                // RULE: All UI code must happen on the main queue!
                // TODO: Get back to the main queue using Grand Central Dispatch (GCD)
                DispatchQueue.main.async
                {
                    // This will execute on the main thread.
                    var locationText = ""
                    if let cityTown = location.cityTown
                    {
                        locationText = "\(cityTown)"
                    }
                    if let state = location.state {
                        locationText += ", \(state)"
                    }
                    self.locationTextField.text = "\(locationText)"
                }
            }
            else
            {
                DispatchQueue.main.async
                {
                    self.locationTextField.text = "Not Found"
                }
            }
        }
    }

    
    func displayTemp(_ textField: UITextField) -> Void
    {
        // Get the weather
        self.weatherService.getCurrentWeather(textField.text!) { (currentWeather) in
            // This is off the Main Queue
            if let currentWeather = currentWeather
            {
                // RULE: All UI code must happen on the main queue!
                // TODO: Get back to the main queue using Grand Central Dispatch (GCD)
                DispatchQueue.main.async
                {
                    // This will execute on the main thread.
                    if let temp_f = currentWeather.temp_f
                    {
                        self.temp_f_Label.text = "\(temp_f)° F"
                    }
                } // End of main thread execution
            }
            else
            {
                DispatchQueue.main.async
                {
                    self.temp_f_Label.text = "° F"
                }
            }
        }
    }
    
    func displayCondition(_ textField: UITextField) -> Void
    {
        self.weatherService.getCondition(textField.text!) { (condition) in
            if let condition = condition
            {
                DispatchQueue.main.async
                {
                    if let icon = URL(string: "https:\(condition.icon!)")
                    {
                        self.conditionImageView.load(url: icon)
                    }
                }
            }
            else
            {
                print("false")
            }
        }
    }
}
    
extension UIImageView
{
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url)
            {
                if let image = UIImage(data: data)
                {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

    
    
