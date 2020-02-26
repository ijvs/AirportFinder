//
//  LocationManager.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationAuthorizationStatus {
    case authorized
    case notDetermined
    case denied
}

protocol LocationRepository {
    var currentLocation: Location? { get }
    var authorizationStatus: LocationAuthorizationStatus { get }
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

    var authorizationStatus: LocationAuthorizationStatus {

        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            return .authorized
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .notDetermined
        }
    }

    func requestLocationAuthorization() {
        self.requestWhenInUseAuthorization()

    }
}
