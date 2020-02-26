//
//  Airport.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

struct Airport: Decodable {
    let identifier: String
    let code: String
    let name: String
    let location: Location
    let city: String
    let countryCode: String

    enum CodingKeys: String, CodingKey {
        case identifier = "airportId"
        case code
        case name
        case location
        case city
        case countryCode
    }
}
