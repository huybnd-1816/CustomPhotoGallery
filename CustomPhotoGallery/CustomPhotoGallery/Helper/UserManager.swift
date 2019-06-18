//
//  UserManager.swift
//  CustomPhotoGallery
//
//  Created by nguyen.duc.huyb on 6/19/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import CoreLocation

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location : CLLocation)
}

class UserManager: NSObject, CLLocationManagerDelegate {
    static let shared = UserManager()
    
    private var locationManager = CLLocationManager()
    var delegate : LocationUpdateProtocol!
    
    private override init () {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
           
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate.locationDidUpdateToLocation(location: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
