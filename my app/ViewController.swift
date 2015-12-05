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
    
    var locations = [CLLocationCoordinate2D]()
    var geocoder = CLGeocoder()
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var unlockedImage: UIImageView!
    
    @IBOutlet weak var unlockButton: UIButton!
    @IBAction func unlockButton(sender: UIButton){
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        unlockButton.hidden = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.Follow, animated: true)
        mapView.delegate = self

        
        //location of locks
        
        let zipLineLocation = CLLocationCoordinate2DMake(50.7162300, -1.8756500)
        let dropPin = CustomPointAnnotation()
        dropPin.coordinate = zipLineLocation
        dropPin.title = "ZipLine"
        mapView.addAnnotation(dropPin)
        
        let arcadeLocation = CLLocationCoordinate2DMake(50.716098, -1.875780)
        let dropPinTwo = CustomPointAnnotation()
        dropPinTwo.coordinate = arcadeLocation
        dropPinTwo.title = "Arcade"
        mapView.addAnnotation(dropPinTwo)

        let beachLocation = CLLocationCoordinate2DMake(50.719914, -1.843552)
        let dropPinThree = CustomPointAnnotation()
        dropPinThree.unlock()
        dropPinThree.coordinate = beachLocation
        dropPinThree.title = "Beach"
        mapView.addAnnotation(dropPinThree)
        
        
        //region for each lock to be opened
        
        let zipLineRegion = CLCircularRegion(center: zipLineLocation, radius: 20, identifier: "ZipLine")
        locationManager.startMonitoringForRegion(zipLineRegion)
        
        let arcadeRegion = CLCircularRegion(center: arcadeLocation, radius: 20, identifier: "Arcade")
        locationManager.startMonitoringForRegion(arcadeRegion)
        
        let beachRegion = CLCircularRegion(center: beachLocation, radius: 20, identifier: "Beach")
        locationManager.startMonitoringForRegion(beachRegion)


    }
    
    @IBAction func mapSwitch(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .Standard
        }

        if sender.selectedSegmentIndex == 1 {
            mapView.mapType = .Satellite
        }
        
    }
    
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "Lock"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
        }
        else {
            anView!.annotation = annotation
        }
        
        let cpa = annotation as! CustomPointAnnotation
        anView!.image = UIImage(named:cpa.imageName)

        
        return anView
        
    }
    
}

extension ViewController: CLLocationManagerDelegate {
        

    
        func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
            unlockButton.hidden = false
            print(region.identifier)
            
            
            
        }
        
        func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
            unlockButton.hidden = true
        }

    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        
        if let newLocation = newLocation {
            
            let testLocation = CLLocation(latitude: 0, longitude: 0)
            //print(newLocation.distanceFromLocation(testLocation) / 1000)
            
        }
        
    }

        
}
