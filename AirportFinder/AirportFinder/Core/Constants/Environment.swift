//
//  Environment.swift
//  AirportFinder
//
//  Created by Israel Jonathan Velázquez Sánchez on 2/26/20.
//  Copyright © 2020 Siker. All rights reserved.
//

import Foundation

enum HostType: String {
    case rapiappi
    case main
}

struct Environment {

    /// Return the base url for the type of host.
    /// - Parameter hostType: Host type.
    static func baseURL(hostType: HostType) -> URL {
        switch hostType {
        case .main:
            // TODO: Find a better way than force unwrap :/
            return URL(string: "https://localhost:8000/")!
        case .rapiappi:
            return URL(string: "https://cometari-airportsfinder-v1.p.rapidapi.com")!
        }
    }

}
