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
    func getCurrentLocation() -> Bindable<Location>
}

protocol RequestLocationAuthorizationUserCase {
    func requestLocationAuthorization()
}

protocol LocationAuthorizationStatusUserCase {
    func getLocationAuthorizationStatus() -> Bindable<LocationAuthorizationStatus>
}

protocol LocationUseCase: GetCurrentLocationUseCase,
    RequestLocationAuthorizationUserCase,
    LocationAuthorizationStatusUserCase { }

class LocationUseCaseImp: LocationUseCase {

    let locationRepository: LocationRepository

    init(locationRepository: LocationRepository = LocationRepositoryImp()) {
        self.locationRepository = locationRepository
    }


    func getCurrentLocation() -> Bindable<Location> {
        return locationRepository.currentLocation
    }
    
    func requestLocationAuthorization() {
        locationRepository.requestLocationAuthorization()
    }

    func getLocationAuthorizationStatus() -> Bindable<LocationAuthorizationStatus> {
        return locationRepository.authorizationStatus
    }
}
