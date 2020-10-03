//
//  NetworkProcessor.swift
//  Weather
//
//  Created by Edwin Guerrero on 9/30/20.
//

import Foundation

class NetworkProcessor
{
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    let url: URL
    
    init(url: URL)
    {
        self.url = url
    }
    
    typealias JSONDictionaryHandler = (([String: Any]?) -> Void)
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryHandler)
    {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request)
        { (data, response, error) in
            if error == nil
            {
                if let httpResponse = response as? HTTPURLResponse
                {
                    switch httpResponse.statusCode
                    {
                        case 200: // successful response
                            if let data = data
                            {
                                //print(data) // prints data size
                                
                                do
                                {
                                    let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                    completion(jsonDictionary as? [String : Any])
                                }
                                catch let error as NSError
                                {
                                    print("Error processing json data: \(error.localizedDescription)")
                                }
                            }
                        default:
                            print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            }
            else
            {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        dataTask.resume() // start download
    }
}
