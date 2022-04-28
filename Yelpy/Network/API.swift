//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
 
    
//    static func getRestaurantDetail(id, completion: @escaping (RestaurantDetail?) -> Void) {
//        let apikey = "NYOn9TZoOEZTMbC8582zqD1kltK1A3xmm1eqFwa9nDGZAVDCu6v9B62J2HqeorcB7285hahhcFQ5ty5rfw816nWBDtAIbTC-5kE4zO4qcJpKVDasRBaWGgXkUdtOYnYx"
//        let url = URL(string: "https://api.yelp.com/v3/businesses/\(id)")!
//        )
//    }

    static func getRestaurants(completion: @escaping ([Restaurant]?) -> Void) {
 
        let apikey = "NYOn9TZoOEZTMbC8582zqD1kltK1A3xmm1eqFwa9nDGZAVDCu6v9B62J2HqeorcB7285hahhcFQ5ty5rfw816nWBDtAIbTC-5kE4zO4qcJpKVDasRBaWGgXkUdtOYnYx"
        
        // Coordinates for San Francisco
        let lat = 40.73183812334082
        let long = -73.93710898109279
        
        
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                // ––––– TODO: Get data from API and return it using completion
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let restDict = dataDictionary["businesses"] as! [[String: Any]]
                
                let restaurants = restDict.map({ Restaurant.init(dict: $0) })
                
                // Using For Loop
//                var restaurants: [Restaurant] = []
//                for dictionary in dataDictionary {
//                    let restaurant = Restaurant.init(dict: dictionary as! [String : Any])
//                    restaurants.append(restaurant)
//                }

                                
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    
    

    
}

    
