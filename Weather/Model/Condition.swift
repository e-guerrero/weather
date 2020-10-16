//
//  Condition.swift
//  Weather
//
//  Created by Edwin Guerrero on 10/13/20.
//

import Foundation
import UIKit

class Condition
{
    let icon: String?
    let text: String?
    
    init(dictionary: [String : Any])
    {
        if let icon = dictionary["icon"] as? String
        {
            self.icon = icon
        } else {
            self.icon = nil
        }
        if let text = dictionary["text"] as? String
        {
            self.text = text
        } else {
            self.text = nil
        }
    }
}
