//
//  LocationUseCase.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import CoreLocation

protocol GetCurrentLocationUseCase {
    func getCurrentLocation(completion: (Location?) -> Void)
}

protocol RequestLocationAuthorizationUserCase {
    func requestLocationAuthorization()
}

protocol LocationUseCase: GetCurrentLocationUseCase, RequestLocationAuthorizationUserCase { }

class LocationUseCaseImp: LocationUseCase {
    let locationManager: LocationRepository

    init(locationManager: LocationRepository = LocationRepositoryImp()) {
        self.locationManager = locationManager
    }

    func getCurrentLocation(completion: (Location?) -> Void) {
        completion(locationManager.currentLocation)
    }

    func requestLocationAuthorization() {
        locationManager.requestLocationAuthorization()
    }
}
