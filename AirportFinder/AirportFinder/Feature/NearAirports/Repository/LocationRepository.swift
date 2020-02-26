//
//  LocationManager.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationRepository {
    var currentLocation: Location? { get }
    func requestLocationAuthorization()
}

class LocationRepositoryImp: CLLocationManager, LocationRepository {
    var currentLocation: Location? {
        guard let coordinate = location?.coordinate else {
            return nil
        }
        return Location(longitude: coordinate.longitude,
                        latitude: coordinate.latitude)
    }

    func requestLocationAuthorization() {
        self.requestWhenInUseAuthorization()
    }
}
