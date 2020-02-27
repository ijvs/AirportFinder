//
//  AirportAnnotation+ViewModel.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/27/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import CoreLocation

extension AirportAnnotation {
    struct ViewModel: AirportViewModel {
        var title: String
        var subtitle: String
        var location: CLLocationCoordinate2D

        init(entity: AirportEntity) {
            title = entity.name
            subtitle = entity.code
            location = CLLocationCoordinate2D(latitude: entity.location.latitude,
                                              longitude: entity.location.longitude)
        }
    }
}
