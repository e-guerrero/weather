//
//  AppDelegate.swift
//  Weather
//
//  Created by Edwin Guerrero on 9/29/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let weatherService = WeatherService(APIKey: "47096294b48b43ee896155647203009")
        weatherService.getCurrentWeather(cityOrTown: "Norcross") { (currentWeather) in
            print(currentWeather!)
            print("temp c: \(currentWeather!.temp_c!)")
            print("temp f: \(currentWeather!.temp_f!)")
            print("humidity: \(currentWeather!.humidity!)")
            print("precipitation (inch): \(currentWeather!.precipInches!)")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

