//
//  DetailViewController.swift
//  Yelpy
//
//  Created by Memo on 5/26/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage
import MapKit


class RestaurantDetailViewController: UIViewController, MKMapViewDelegate {

    // Configure outlets
    // NOTE: Make sure to set images to "Content Mode: Aspect Fill" on the
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    
    // Initialize restaurant variable
    var r: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOutlets()
    }

    
    func configureOutlets() {
        nameLabel.text = r.name
        reviewsLabel.text = String(r.reviews)
        starImage.image = Stars.dict[r.rating]!
        headerImage.af.setImage(withURL: r.imageURL!)
        
        // 1) get longitude and latitude from coordinates property
        let latitude = r.latitude
        let longitude = r.longitude

        // 2) initialize coordinate point for restaurant
        let locationCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees.init(latitude), CLLocationDegrees.init(longitude))

        // 3) initialize region object using restaurant's coordinates
        let restaurantRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(latitude, longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

        // 4) set region in mapView to be that of restaurants
        mapView.setRegion(restaurantRegion, animated: true)
        
        // Add tint opacity to image to make text stand out
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.3) //change to your liking
        tintView.frame = CGRect(x: 0, y: 0, width: headerImage.frame.width, height: headerImage.frame.height)

        headerImage.addSubview(tintView)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        return mapView.dequeueReusableAnnotationView(withIdentifier: "removeMe")
        
    }


}
