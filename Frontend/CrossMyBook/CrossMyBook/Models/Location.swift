//
//  Location.swift
//  FindMyCar
//
//  Created by Azathoth on 11/8/22.
//

import Foundation
import CoreLocation

class Location: NSObject {
    
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var locationManager = CLLocationManager()
    
    override init() {
        self.latitude = 0.00
        self.longitude = 0.00
        super.init()
    }
    
    func getCurrentLocation() {
        clearLocation()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        if let currLocation = locationManager.location {
            self.latitude = currLocation.coordinate.latitude
            self.longitude = currLocation.coordinate.longitude
        }
    }
    

    
    func clearLocation () {
      self.latitude = 0.00
      self.longitude = 0.00
    }

}
