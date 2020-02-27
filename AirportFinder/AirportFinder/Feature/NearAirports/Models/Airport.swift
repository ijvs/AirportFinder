//
//  Airport.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/25/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

protocol AirportEntity {
    var identifier: String { get }
    var code: String { get }
    var name: String { get }
    var location: Location { get }
    var city: String { get }
    var countryCode: String { get }
}

struct Airport: Decodable, AirportEntity {
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
