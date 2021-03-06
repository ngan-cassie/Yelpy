//
//  Restaurant.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Restaurant {
    
    // ––––– Lab 2 TODO: Establish Properties –––––
    var id: String
    var imageURL: URL?
    var url: URL?
    var name: String
    var mainCategory: String
    var phone: String
    var rating: Double
    var reviews: Int
    var latitude: Double
    var longitude: Double


    init(dict: [String: Any]) {
        id = dict["id"] as! String
        imageURL = URL(string: dict["image_url"] as! String)
        name = dict["name"] as! String
        rating = dict["rating"] as! Double
        reviews = dict["review_count"] as! Int
        phone = dict["display_phone"] as! String
        url = URL(string: dict["url"] as! String)
        mainCategory = Restaurant.getMainCategory(dict: dict)
        let coordinates = Restaurant.getCoordinates(dict: dict)
        latitude = coordinates["latitude"]!
        longitude = coordinates["longitude"]!
        
    }
    
    // Helper function to get First category from restaurant
    static func getMainCategory(dict: [String:Any]) -> String {
        let categories = dict["categories"] as! [[String: Any]]
        return categories[0]["title"] as! String
    }

    static func getCoordinates(dict: [String:Any]) -> [String:Double] {
        let coordinates = dict["coordinates"] as! [String: Double]
        return coordinates
    }
    
}
