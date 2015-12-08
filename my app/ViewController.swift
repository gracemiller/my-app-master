//
//  ViewController.swift
//  my app
//
//  Created by Grace Miller (i7693118) on 23/11/2015.
//  Copyright © 2015 Grace Miller. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var selectedItem: String?
    
    var locations = [CLLocationCoordinate2D]()
    var geocoder = CLGeocoder()
    
    var points = buildAnnotations()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var unlockedImage: UIImageView!
    @IBOutlet weak var directionArrow: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.Follow, animated: true)
        mapView.delegate = self
        
        for point in points {
            mapView.addAnnotation(point)
            locationManager.startMonitoringForRegion(point.region)
        }
        
        mapView.showAnnotations(points, animated: false)

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "unlockButton" {
            let vc = segue.destinationViewController as! DetailViewController
            vc.name = selectedItem
        }
        
      
    }
    
    
    @IBAction func mapSwitch(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .Standard
        }

        if sender.selectedSegmentIndex == 1 {
            mapView.mapType = .Satellite
        }
        
    }
    
    func refreshMap() {
        
        mapView.removeAnnotations(points)
        
        for point in points {
            mapView.addAnnotation(point)
        }
    }
    
    
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let cpa = view.annotation as! CustomPointAnnotation
        selectedItem = cpa.name
        
        performSegueWithIdentifier("unlockButton", sender: self)

        
    }
   
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "Lock"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        let cpa = annotation as! CustomPointAnnotation
        
        
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
            if !cpa.isLocked {
        }
            

        }
        else {
            anView!.annotation = annotation
        }
        
        if cpa.isLocked {
            anView!.image = UIImage(named: "lock")
        } else {
            anView!.image = UIImage(named: "unlocked")
            anView!.rightCalloutAccessoryView = UIButton(type: .InfoLight)
        }
        
        return anView
        
    }
}

//regions

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print(region.identifier)
        
        for point in points {
            if point.name == region.identifier {
                point.unlock()
            }
        }
        
        refreshMap()
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        for point in points {
            if point.name == region.identifier {
                point.lock()
            }
        }
        
        refreshMap()
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let newLocation = locations.last
        
    }
    
        
}
