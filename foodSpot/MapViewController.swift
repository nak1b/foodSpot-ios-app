//
//  MapViewController.swift
//  foodSpot
//
//  Created by Nakib on 3/27/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
       
        mapView.delegate = self
        
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
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
        
        //Reuse annotaion if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation,
            reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(data: restaurant.image!)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        //pin color
        annotationView?.pinTintColor = UIColor(red: 255/255.0, green: 45/255.0, blue: 85/255.0, alpha: 1.0)
        
        return annotationView
    }

}
