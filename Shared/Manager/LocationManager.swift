//
//  LocationManager.swift
//  Uber-SwiftUI (iOS)
//
//  Created by Bhoopendra Umrao on 4/12/23.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        manager.stopUpdatingLocation()
    }
}

