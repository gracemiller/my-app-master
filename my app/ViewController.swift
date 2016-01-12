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
//import Gifu


class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var selectedPoint: CLLocationCoordinate2D?
    
    /*
    let imageView = AnimatableImageView
    imageView.animateWithImage(named: "launch.gif")
    */
    
    var selectedItem: CustomPointAnnotation?
    var locations = [CLLocationCoordinate2D]()
    var geocoder = CLGeocoder()
    var points = buildAnnotations()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var arrow: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self

        mapView.delegate = self
        
        for point in points {
            mapView.addAnnotation(point)
            locationManager.startMonitoringForRegion(point.region)
        }
        
        mapView.showAnnotations(points, animated: false)
        arrow.alpha = 0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "unlockButton" {
            let vc = segue.destinationViewController as! TableViewController
            vc.place = selectedItem
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
        
        mapView.setUserTrackingMode(.Follow, animated: true)
    }
    
    
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let cpa = view.annotation as! CustomPointAnnotation
        selectedItem = cpa
        
        performSegueWithIdentifier("unlockButton", sender: self)

    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        selectedPoint = view.annotation?.coordinate
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        if let selectedPoint = selectedPoint {
            let pointToGo = selectedPoint
            let userLocation2d = CLLocationCoordinate2D(latitude: userLocation.location!.coordinate.latitude, longitude: userLocation.location!.coordinate.longitude)
            
            userLocation.title =  "\(Double(userLocation.location!.distanceFromLocation(CLLocation(latitude: 50.719799, longitude: -1.879439))).roundToPlaces(2)) Meters Away"
            
            UIView.animateWithDuration(0.5) { _ in
                self.arrow.alpha = 1
                self.arrow.transform = CGAffineTransformMakeRotation(getBearingBetweenTwoPoints(userLocation2d, y: pointToGo))
            }
        } else {
            
        }
        
        
        
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
        }else {
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


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entering \(region.identifier)")
        
        for point in points {
            if point.name == region.identifier {
                point.unlock()
            }
        }
        
        refreshMap()
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Leaving \(region.identifier)")
        for point in points {
            if point.name == region.identifier {
                point.lock()
            }
        }
        
        refreshMap()
        
    }
    
}