//
//  MapViewController.swift
//  foodSpot
//
//  Created by Nakib on 3/27/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import MapKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        //convert address to co ordinates
        let geoCoder = CLGeocoder();
        geoCoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
            if error != nil{
                print(error)
                return
            }
            
            if let placemarks = placemarks{
                //get first place
                let placemark = placemarks[0]
                
                //Add anotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location{
                    annotation.coordinate = location.coordinate
                    
                    //display annotation on map
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
                
            }
           
        }
    }

}
