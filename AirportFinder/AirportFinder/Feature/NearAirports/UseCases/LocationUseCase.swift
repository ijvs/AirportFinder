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

protocol LocationAuthorizationStatusUserCase {
    func getLocationAuthorizationStatus() -> LocationAuthorizationStatus
}

protocol LocationUseCase: GetCurrentLocationUseCase,
    RequestLocationAuthorizationUserCase,
    LocationAuthorizationStatusUserCase { }

class LocationUseCaseImp: LocationUseCase {
    let locationRepository: LocationRepository

    init(locationRepository: LocationRepository = LocationRepositoryImp()) {
        self.locationRepository = locationRepository
    }

    func getCurrentLocation(completion: (Location?) -> Void) {
        completion(locationRepository.currentLocation)
    }

    func requestLocationAuthorization() {
        locationRepository.requestLocationAuthorization()
    }

    func getLocationAuthorizationStatus() -> LocationAuthorizationStatus {
        return locationRepository.authorizationStatus
    }
}
