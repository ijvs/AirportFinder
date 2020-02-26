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
    var currentLocation: Bindable<Location> { get }
    var authorizationStatus: Bindable<LocationAuthorizationStatus> { get }
    func requestLocationAuthorization()
}

class LocationRepositoryImp: CLLocationManager, LocationRepository {

    override init() {
        super.init()
        delegate = self
        pausesLocationUpdatesAutomatically = true
        startUpdatingLocation()
        activityType = .otherNavigation
        desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }

    deinit {
        stopMonitoringSignificantLocationChanges()
    }

    var currentLocation: Bindable<Location> = Bindable<Location>()
    var authorizationStatus: Bindable<LocationAuthorizationStatus> = Bindable<LocationAuthorizationStatus>()

    func requestLocationAuthorization() {
        self.requestWhenInUseAuthorization()

    }
}

// MARK: - CLLocationManagerDelegate
extension LocationRepositoryImp: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            authorizationStatus.update(with: .authorized)
        case .denied, .restricted:
            authorizationStatus.update(with: .denied)
        case .notDetermined:
            authorizationStatus.update(with: .notDetermined)
        @unknown default:
            authorizationStatus.update(with: .notDetermined)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else {
            return
        }
        print("🌎 Updated location \(coordinate)")
        let updateValue = Location(longitude: coordinate.longitude, latitude: coordinate.latitude)
        currentLocation.update(with: updateValue)
    }
}
