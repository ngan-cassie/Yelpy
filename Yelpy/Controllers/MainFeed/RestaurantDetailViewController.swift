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


class RestaurantDetailViewController: UIViewController, MKMapViewDelegate, PostImageViewControllerDelegate {

    // Configure outlets
    
    // connect to MapView + add annotation view
    @IBOutlet weak var mapView: MKMapView!
    var annotationView: MKAnnotationView!
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    
    // Initialize restaurant variable
    var r: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOutlets()
        
        mapView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostImageVC" {
            let postImageVC = segue.destination as! PostImageViewController
            // NOTE: PLEASE FOLLOW LAB BEFORE ASKING FOR HELP ON THIS
            postImageVC.delegate = self
        }
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
        
        // 5) instantiate annotation object to show pin on map
        let annotation = MKPointAnnotation()
        
        // 6) set annotation's properties
        annotation.coordinate = locationCoordinate
        annotation.title = r.name
        
        // 7) drop pin on map using restaurant's coordinates
        mapView.addAnnotation(annotation)
        
        // Add tint opacity to image to make text stand out
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.3) //change to your liking
        tintView.frame = CGRect(x: 0, y: 0, width: headerImage.frame.width, height: headerImage.frame.height)

        headerImage.addSubview(tintView)
    }
    
    // 8) Configure annotation view using protocol method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Create a reuse identifier constant for annotationView
        let reuseID = "myAV"
        print("mapView protocol called")
        
        self.annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView?.canShowCallout = true
            // 9) Add info button to annotation view
            let annotationViewButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            annotationViewButton.setImage(UIImage(named: "camera"), for: .normal)
            annotationView?.leftCalloutAccessoryView = annotationViewButton
        }
//        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
//        imageView.image = UIImage(named: "camera")
        
        return annotationView
    }
    
    // action to execute when user taps annotation views accessory buttons
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // perform segue to PostImageVC
        self.performSegue(withIdentifier: "toPostImageVC", sender: nil)
    }
    func imageSelected(controller: PostImageViewController, image: UIImage) {
        let annotationViewButton = UIButton(frame: CGRect(x: 0, y:0, width: 50, height: 50))
        annotationViewButton.setImage(image, for: .normal)
       
        self.annotationView?.leftCalloutAccessoryView = annotationViewButton
}
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
        print("Unwind to Restaurant Detail View Controller")
    }
}
