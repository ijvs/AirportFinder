//
//  AirportAnnotation.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/27/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation
import MapKit

class AirportAnnotation: MKPointAnnotation {
    init(model: ViewModel) {
        super.init()
        title = model.title
        subtitle = model.subtitle
        coordinate = model.location
    }
}
