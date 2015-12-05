//
//  SecondViewController.swift
//  my app
//
//  Created by Grace Miller (i7693118) on 23/11/2015.
//  Copyright © 2015 Grace Miller. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var locations = [CLLocationCoordinate2D]()
    var geocoder = CLGeocoder()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.setUserTrackingMode(.Follow, animated: true)

    }

}

extension SecondViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        
        if let newLocation = newLocation {
            print(newLocation)
            
            let testLocation = CLLocation(latitude: 0, longitude: 0)
            print(newLocation.distanceFromLocation(testLocation) / 1000)
            
        }
        
    }
}
